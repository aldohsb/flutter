import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';
import 'package:audioplayers/audioplayers.dart';

// ─────────────────────────────────────────────
// DATA MODEL
// ─────────────────────────────────────────────

class TrackSession {
  final DateTime startedAt;
  int durationSeconds;
  TrackSession({required this.startedAt, this.durationSeconds = 0});

  Map<String, dynamic> toJson() => {
        'startedAt': startedAt.toIso8601String(),
        'durationSeconds': durationSeconds,
      };
  factory TrackSession.fromJson(Map<String, dynamic> j) => TrackSession(
        startedAt: DateTime.parse(j['startedAt']),
        durationSeconds: j['durationSeconds'] ?? 0,
      );
}

class TrackTimer {
  String name;
  int targetSeconds; // 0 = no target
  List<TrackSession> sessions;

  TrackTimer({required this.name, this.targetSeconds = 0, List<TrackSession>? sessions})
      : sessions = sessions ?? [];

  int get totalSeconds => sessions.fold(0, (s, e) => s + e.durationSeconds);

  Map<String, dynamic> toJson() => {
        'name': name,
        'targetSeconds': targetSeconds,
        'sessions': sessions.map((s) => s.toJson()).toList(),
      };
  factory TrackTimer.fromJson(Map<String, dynamic> j) => TrackTimer(
        name: j['name'],
        targetSeconds: j['targetSeconds'] ?? 0,
        sessions: (j['sessions'] as List? ?? [])
            .map((s) => TrackSession.fromJson(s))
            .toList(),
      );
}

// ─────────────────────────────────────────────
// PERSISTENCE
// ─────────────────────────────────────────────

class Storage {
  static File get _file {
    final dir = File(Platform.resolvedExecutable).parent;
    return File('${dir.path}/timer_tracks.json');
  }

  static Future<List<TrackTimer>> load() async {
    try {
      if (!await _file.exists()) return [];
      final raw = await _file.readAsString();
      final list = jsonDecode(raw) as List;
      return list.map((e) => TrackTimer.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> save(List<TrackTimer> tracks) async {
    await _file.writeAsString(jsonEncode(tracks.map((t) => t.toJson()).toList()));
  }
}

// ─────────────────────────────────────────────
// MAIN
// ─────────────────────────────────────────────

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  const WindowOptions windowOptions = WindowOptions(
    size: Size(480, 60),
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
    windowButtonVisibility: false,
    alwaysOnTop: true,
  );

  await windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.setOpacity(0.88);
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const TimerApp());
}

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.dark(primary: Colors.tealAccent),
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(Colors.white24),
        ),
      ),
      home: const TimerScreen(),
    );
  }
}

// ─────────────────────────────────────────────
// TIMER SCREEN
// ─────────────────────────────────────────────

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});
  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  // ── Stopwatch (count-up) ──
  Timer? _ticker;
  int _elapsed = 0; // seconds ticked up
  bool _running = false;

  // ── Ding every 5 min ──
  final AudioPlayer _audio = AudioPlayer();
  int _lastDingMinute = -1;

  // ── Window ──
  double _opacity = 0.88;
  bool _showPanel = false;

  // ── Track timers ──
  List<TrackTimer> _tracks = [];
  int? _activeTrackIndex; // which track is currently accumulating
  int? _selectedTrackIndex; // which track is highlighted (selected)
  TrackSession? _activeSession;

  @override
  void initState() {
    super.initState();
    Storage.load().then((t) => setState(() => _tracks = t));
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _audio.dispose();
    super.dispose();
  }

  // ── Formatters ──
  String _fmt(int sec) {
    final h = sec ~/ 3600;
    final m = (sec % 3600) ~/ 60;
    final s = sec % 60;
    return '${h.toString().padLeft(2, '0')}:'
        '${m.toString().padLeft(2, '0')}:'
        '${s.toString().padLeft(2, '0')}';
  }

  String _fmtShort(int sec) {
    final h = sec ~/ 3600;
    final m = (sec % 3600) ~/ 60;
    if (h > 0) return '${h}j ${m}m';
    return '${m}m ${sec % 60}s';
  }

  // ── Controls ──
  void _play() {
    setState(() => _running = true);
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _elapsed++;
        _activeSession?.durationSeconds++;
        _checkDing();
      });
    });
  }

  void _pause() {
    _ticker?.cancel();
    setState(() => _running = false);
    _saveActiveSession();
  }

  void _stop() {
    _ticker?.cancel();
    _saveActiveSession();
    setState(() {
      _running = false;
      _elapsed = 0;
      _lastDingMinute = -1;
      _activeSession = null;
    });
  }

  void _saveActiveSession() {
    if (_activeTrackIndex != null && _activeSession != null) {
      Storage.save(_tracks);
    }
  }

  void _checkDing() {
    if (_elapsed % 300 == 0 && _elapsed > 0) {
      final mark = _elapsed ~/ 300;
      if (mark != _lastDingMinute) {
        _lastDingMinute = mark;
        _audio.play(AssetSource('ding.mp3'));
      }
    }
  }

  Future<void> _adjustOpacity(double delta) async {
    _opacity = (_opacity + delta).clamp(0.2, 1.0);
    await windowManager.setOpacity(_opacity);
    setState(() {});
  }

  // ── Panel toggle ──
  void _togglePanel() async {
    _showPanel = !_showPanel;
    final newH = _showPanel ? 420.0 : 60.0;
    await windowManager.setSize(Size(520, newH));
    setState(() {});
  }

  // ── Track: select (highlight only, no auto-play) ──
  void _selectTrack(int index) {
    _saveActiveSession();
    if (_selectedTrackIndex == index) {
      setState(() => _selectedTrackIndex = null);
    } else {
      setState(() => _selectedTrackIndex = index);
    }
  }

  // ── Track: start timer on selected/given track ──
  void _startTrack(int index) {
    if (_activeTrackIndex == index && _running) {
      // pause current
      _pause();
      return;
    }
    _saveActiveSession();
    final session = TrackSession(startedAt: DateTime.now());
    _tracks[index].sessions.add(session);
    setState(() {
      _activeTrackIndex = index;
      _selectedTrackIndex = index;
      _activeSession = session;
    });
    if (!_running) _play();
  }

  // ── Track: add new ──
  void _addTrack() async {
    final result = await showDialog<TrackTimer>(
      context: context,
      builder: (_) => const _TrackDialog(),
    );
    if (result != null) {
      setState(() => _tracks.add(result));
      Storage.save(_tracks);
    }
  }

  // ── Track: edit ──
  void _editTrack(int index) async {
    final result = await showDialog<TrackTimer>(
      context: context,
      builder: (_) => _TrackDialog(existing: _tracks[index]),
    );
    if (result != null) {
      setState(() {
        _tracks[index].name = result.name;
        _tracks[index].targetSeconds = result.targetSeconds;
      });
      Storage.save(_tracks);
    }
  }

  // ── Track: delete ──
  void _deleteTrack(int index) {
    if (_activeTrackIndex == index) {
      _activeTrackIndex = null;
      _activeSession = null;
    }
    setState(() => _tracks.removeAt(index));
    Storage.save(_tracks);
  }

  // ── Track: clear sessions ──
  void _clearSessions(int index) {
    setState(() => _tracks[index].sessions.clear());
    Storage.save(_tracks);
  }

  // ─────────────────────────────────────────────
  // BUILD
  // ─────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Main container
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.88),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white.withOpacity(0.08)),
              ),
              child: Column(
                children: [
                  _buildTopBar(),
                  if (_showPanel) Expanded(child: _buildPanel()),
                ],
              ),
            ),
          ),
          // Resize handle — bottom-right corner
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onPanUpdate: (d) async {
                final size = await windowManager.getSize();
                final newW = (size.width + d.delta.dx).clamp(280.0, 900.0);
                final newH = (size.height + d.delta.dy).clamp(60.0, 800.0);
                await windowManager.setSize(Size(newW, newH));
              },
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(14)),
                ),
                child: const Icon(Icons.open_in_full,
                    size: 10, color: Colors.white24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Top bar ──
  Widget _buildTopBar() {
    return SizedBox(
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Drag handle strip
          GestureDetector(
            onPanStart: (_) => windowManager.startDragging(),
            child: Container(
              width: 10,
              height: 60,
              color: Colors.transparent,
            ),
          ),
          const SizedBox(width: 6),

          // Active track name badge
          if (_activeTrackIndex != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                color: Colors.tealAccent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.tealAccent.withOpacity(0.3)),
              ),
              child: Text(
                _tracks[_activeTrackIndex!].name,
                style: const TextStyle(
                    fontSize: 10, color: Colors.tealAccent, letterSpacing: 0.5),
                overflow: TextOverflow.ellipsis,
              ),
            ),

          // Timer display
          Text(
            _fmt(_elapsed),
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 34,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(width: 8),

          // Progress ring (if track active with target)
          if (_activeTrackIndex != null &&
              _tracks[_activeTrackIndex!].targetSeconds > 0)
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                value: (_tracks[_activeTrackIndex!].totalSeconds /
                        _tracks[_activeTrackIndex!].targetSeconds)
                    .clamp(0.0, 1.0),
                strokeWidth: 3,
                backgroundColor: Colors.white12,
                valueColor: const AlwaysStoppedAnimation(Colors.tealAccent),
              ),
            )
          else
            const SizedBox(width: 4),

          const SizedBox(width: 6),

          // Play/pause
          _iconBtn(
            _running ? Icons.pause_rounded : Icons.play_arrow_rounded,
            _running ? _pause : _play,
            _running ? Colors.amberAccent : Colors.tealAccent,
          ),
          // Stop
          _iconBtn(Icons.stop_rounded, _stop, Colors.redAccent.shade100),

          const Spacer(),

          // Panel toggle
          _iconBtn(
            _showPanel ? Icons.expand_less : Icons.list_alt_rounded,
            _togglePanel,
            _showPanel ? Colors.tealAccent : Colors.white54,
            size: 18,
          ),

          const SizedBox(width: 2),

          // Opacity + close
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _tinyBtn(Icons.brightness_high, () => _adjustOpacity(0.1)),
              _tinyBtn(Icons.brightness_low, () => _adjustOpacity(-0.1)),
            ],
          ),
          _tinyBtn(Icons.close, () => windowManager.close(),
              color: Colors.redAccent.shade100),

          const SizedBox(width: 8),
        ],
      ),
    );
  }

  // ── Panel ──
  Widget _buildPanel() {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.07))),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 6),
            child: Row(
              children: [
                const Text('TRACK TIMERS',
                    style: TextStyle(
                        fontSize: 11,
                        color: Colors.white38,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w600)),
                const Spacer(),
                GestureDetector(
                  onTap: _addTrack,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.tealAccent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                          color: Colors.tealAccent.withOpacity(0.3)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 13, color: Colors.tealAccent),
                        SizedBox(width: 4),
                        Text('Tambah',
                            style: TextStyle(
                                fontSize: 11, color: Colors.tealAccent)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // List
          Expanded(
            child: _tracks.isEmpty
                ? const Center(
                    child: Text('Belum ada track timer',
                        style: TextStyle(color: Colors.white24, fontSize: 13)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    itemCount: _tracks.length,
                    itemBuilder: (_, i) => _buildTrackCard(i),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackCard(int i) {
    final t = _tracks[i];
    final isSelected = _selectedTrackIndex == i;
    final isTracking = _activeTrackIndex == i && _running;
    final progress = t.targetSeconds > 0
        ? (t.totalSeconds / t.targetSeconds).clamp(0.0, 1.0)
        : null;
    final done = progress != null && progress >= 1.0;

    return GestureDetector(
      onTap: () => _selectTrack(i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.tealAccent.withOpacity(0.07)
              : Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isTracking
                ? Colors.tealAccent.withOpacity(0.5)
                : isSelected
                    ? Colors.tealAccent.withOpacity(0.2)
                    : Colors.white.withOpacity(0.06),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Running indicator dot
                Container(
                  width: 7,
                  height: 7,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isTracking
                        ? Colors.tealAccent
                        : Colors.white.withOpacity(0.15),
                  ),
                ),

                // Name
                Expanded(
                  child: Text(t.name,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.white60)),
                ),

                // Total time
                Text(
                  _fmtShort(t.totalSeconds),
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 13,
                    color: done ? Colors.greenAccent : Colors.white54,
                  ),
                ),

                if (t.targetSeconds > 0) ...[
                  const Text(' / ',
                      style: TextStyle(color: Colors.white24, fontSize: 12)),
                  Text(
                    _fmtShort(t.targetSeconds),
                    style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        color: Colors.white30),
                  ),
                ],

                const SizedBox(width: 6),

                // ▶ / ⏸ start-track button (explicit, separate from select)
                GestureDetector(
                  onTap: () => _startTrack(i),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: isTracking
                          ? Colors.amberAccent.withOpacity(0.15)
                          : Colors.tealAccent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(
                      isTracking ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      size: 15,
                      color: isTracking ? Colors.amberAccent : Colors.tealAccent,
                    ),
                  ),
                ),

                const SizedBox(width: 4),

                // Edit
                GestureDetector(
                  onTap: () => _editTrack(i),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.edit_outlined,
                        size: 14, color: Colors.white30),
                  ),
                ),
                // Clear sessions
                GestureDetector(
                  onTap: () => _clearSessions(i),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.refresh, size: 14, color: Colors.white30),
                  ),
                ),
                // Delete
                GestureDetector(
                  onTap: () => _deleteTrack(i),
                  child: const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.delete_outline,
                        size: 14, color: Colors.redAccent),
                  ),
                ),
              ],
            ),

            // Progress bar
            if (progress != null) ...[
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 3,
                  backgroundColor: Colors.white10,
                  valueColor: AlwaysStoppedAnimation(
                      done ? Colors.greenAccent : Colors.tealAccent),
                ),
              ),
            ],

            // Sessions list
            if (t.sessions.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...t.sessions.reversed.take(5).map((s) => Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      children: [
                        const Icon(Icons.schedule,
                            size: 11, color: Colors.white24),
                        const SizedBox(width: 5),
                        Text(
                          _formatDateTime(s.startedAt),
                          style: const TextStyle(
                              fontSize: 11, color: Colors.white30),
                        ),
                        const Spacer(),
                        Text(
                          _fmtShort(s.durationSeconds),
                          style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                              color: Colors.white38),
                        ),
                      ],
                    ),
                  )),
              if (t.sessions.length > 5)
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    '+${t.sessions.length - 5} sesi lainnya',
                    style:
                        const TextStyle(fontSize: 10, color: Colors.white24),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    String day;
    if (diff.inDays == 0) {
      day = 'Hari ini';
    } else if (diff.inDays == 1) {
      day = 'Kemarin';
    } else {
      day = '${dt.day}/${dt.month}/${dt.year}';
    }
    return '$day ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap, Color color,
      {double size = 24}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: size),
      ),
    );
  }

  Widget _tinyBtn(IconData icon, VoidCallback onTap,
      {Color color = Colors.white38}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 3),
        child: Icon(icon, color: color, size: 15),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// ADD/EDIT TRACK DIALOG
// ─────────────────────────────────────────────

class _TrackDialog extends StatefulWidget {
  final TrackTimer? existing;
  const _TrackDialog({this.existing});
  @override
  State<_TrackDialog> createState() => _TrackDialogState();
}

class _TrackDialogState extends State<_TrackDialog> {
  late TextEditingController _nameCtrl;
  late TextEditingController _hourCtrl;
  late TextEditingController _minCtrl;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _nameCtrl = TextEditingController(text: e?.name ?? '');
    final h = e != null ? e.targetSeconds ~/ 3600 : 0;
    final m = e != null ? (e.targetSeconds % 3600) ~/ 60 : 0;
    _hourCtrl = TextEditingController(text: h.toString());
    _minCtrl = TextEditingController(text: m.toString());
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _hourCtrl.dispose();
    _minCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;
    return Dialog(
      backgroundColor: const Color(0xFF1A1A1A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isEdit ? 'Edit Track Timer' : 'Track Timer Baru',
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            const SizedBox(height: 16),

            // Name
            const Text('Nama', style: TextStyle(fontSize: 12, color: Colors.white54)),
            const SizedBox(height: 6),
            TextField(
              controller: _nameCtrl,
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Contoh: Belajar Flutter',
                hintStyle: const TextStyle(color: Colors.white24),
                filled: true,
                fillColor: Colors.white.withOpacity(0.06),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
              ),
            ),

            const SizedBox(height: 14),

            // Target
            const Text('Target waktu (opsional)',
                style: TextStyle(fontSize: 12, color: Colors.white54)),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _hourCtrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: const TextStyle(color: Colors.white24),
                      suffixText: 'jam',
                      suffixStyle:
                          const TextStyle(color: Colors.white38, fontSize: 12),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.06),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _minCtrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: '0',
                      hintStyle: const TextStyle(color: Colors.white24),
                      suffixText: 'menit',
                      suffixStyle:
                          const TextStyle(color: Colors.white38, fontSize: 12),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.06),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Batal',
                      style: TextStyle(color: Colors.white38)),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    final name = _nameCtrl.text.trim();
                    if (name.isEmpty) return;
                    final h = int.tryParse(_hourCtrl.text) ?? 0;
                    final m = int.tryParse(_minCtrl.text) ?? 0;
                    Navigator.pop(
                      context,
                      TrackTimer(
                        name: name,
                        targetSeconds: h * 3600 + m * 60,
                      ),
                    );
                  },
                  child: Text(isEdit ? 'Simpan' : 'Tambah'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}