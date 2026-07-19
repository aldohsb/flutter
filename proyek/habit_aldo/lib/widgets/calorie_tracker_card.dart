import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/calorie_entry.dart';
import '../providers/calorie_provider.dart';
import '../theme/app_theme.dart';

class CalorieTrackerCard extends StatelessWidget {
  const CalorieTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CalorieProvider>(
      builder: (context, cp, _) {
        final total = cp.todayTotal;
        final target = cp.dailyTarget;
        final pct = cp.todayPercent;
        final isOver = pct > 100;
        final pctColor = isOver ? AppTheme.errorRed : AppTheme.successGreen;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.sage200),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──
                Row(
                  children: [
                    const Text('🍽️', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text('Kalori', style: Theme.of(context).textTheme.titleMedium),
                    const Spacer(),
                    _TargetButton(
                      target: target,
                      onTap: () => _showTargetDialog(context, cp),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // ── Total + Add ──
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hari ini',
                              style: Theme.of(context).textTheme.labelSmall),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                '$total',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(fontSize: 32, color: pctColor),
                              ),
                              const SizedBox(width: 4),
                              Text('/ $target kkal',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: AppTheme.stone500)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _showAddSheet(context, cp, DateTime.now()),
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: const Text('Catat'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.sage600,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ── Progress bar ──
                if (target > 0) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: (pct / 100).clamp(0.0, 1.5),
                      minHeight: 8,
                      backgroundColor: AppTheme.stone200,
                      valueColor: AlwaysStoppedAnimation(pctColor),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: pctColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: pctColor.withValues(alpha: 0.4)),
                        ),
                        child: Text(
                          '${pct.toStringAsFixed(0)}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: pctColor,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isOver
                            ? '${total - target} kkal melebihi target'
                            : '${target - total} kkal tersisa',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: pctColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
                ],

                // ── Today entries (last 4) ──
                if (cp.todayEntries.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 6),
                  ...cp.todayEntries.reversed.take(4).map(
                        (e) => _MiniCalorieRow(
                          entry: e,
                          onDelete: () => cp.deleteEntry(e.id),
                        ),
                      ),
                  if (cp.todayEntries.length > 4)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        '+ ${cp.todayEntries.length - 4} item lainnya',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppTheme.sage600),
                      ),
                    ),
                ],

                // ── Edit past ──
                const SizedBox(height: 8),
                TextButton.icon(
                  onPressed: () => _showPastDatePicker(context, cp),
                  icon: const Icon(Icons.edit_calendar_outlined,
                      size: 14, color: AppTheme.sage600),
                  label: Text(
                    'Catat / edit kalori hari lain',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: AppTheme.sage600),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showTargetDialog(BuildContext context, CalorieProvider cp) {
    final ctrl = TextEditingController(text: cp.dailyTarget.toString());
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.stone100,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Target Kalori Harian',
            style: Theme.of(ctx).textTheme.titleLarge),
        content: TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Target (kkal)',
            suffixText: 'kkal',
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal')),
          ElevatedButton(
            onPressed: () {
              final v = int.tryParse(ctrl.text);
              if (v != null && v > 0) {
                cp.setDailyTarget(v);
                Navigator.pop(ctx);
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  Future<void> _showPastDatePicker(
      BuildContext context, CalorieProvider cp) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && context.mounted) {
      _showAddSheet(context, cp, picked);
    }
  }

  void _showAddSheet(BuildContext context, CalorieProvider cp, DateTime date) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddCalorieSheet(cp: cp, date: date),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Add Calorie Bottom Sheet
// ═══════════════════════════════════════════════════════════════
class _AddCalorieSheet extends StatefulWidget {
  final CalorieProvider cp;
  final DateTime date;
  const _AddCalorieSheet({required this.cp, required this.date});

  @override
  State<_AddCalorieSheet> createState() => _AddCalorieSheetState();
}

class _AddCalorieSheetState extends State<_AddCalorieSheet>
    with SingleTickerProviderStateMixin {
  final _searchCtrl = TextEditingController();
  String _query = '';
  final Map<String, int> _qty = {};
  late TabController _tabCtrl;

  List<SearchableFoodItem> get _results =>
      widget.cp.searchFoods(_query);

  List<CalorieEntry> get _dateEntries =>
      widget.cp.entriesForDate(widget.date);
  int get _dateTotal => widget.cp.totalForDate(widget.date);

  bool get _isToday {
    final now = DateTime.now();
    return widget.date.year == now.year &&
        widget.date.month == now.month &&
        widget.date.day == now.day;
  }

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
    for (final f in kFoodPresets) {
      _qty[f.name] = 1;
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _tabCtrl.dispose();
    super.dispose();
  }

  int _getQty(String name) => _qty[name] ?? 1;
  void _setQty(String name, int v) => setState(() => _qty[name] = v);

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final dateLabel = _isToday
        ? 'Hari Ini'
        : DateFormat('EEEE, d MMM yyyy').format(widget.date);

    return Container(
      margin: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      decoration: BoxDecoration(
        color: AppTheme.stone100,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Container(
            width: 36, height: 4,
            decoration: BoxDecoration(
                color: AppTheme.stone300,
                borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 12),

          // Title + total
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Log Kalori',
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(dateLabel,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(color: AppTheme.sage600)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.sage100,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppTheme.sage300),
                  ),
                  child: Text(
                    '$_dateTotal kkal',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.sage700,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Tabs
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppTheme.stone200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TabBar(
              controller: _tabCtrl,
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.stone300.withValues(alpha: 0.5),
                    blurRadius: 4, offset: const Offset(0, 1),
                  )
                ],
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              labelColor: AppTheme.sage700,
              unselectedLabelColor: AppTheme.stone500,
              labelStyle: const TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600),
              tabs: const [
                Tab(text: 'Pilih Makanan'),
                Tab(text: 'Log Hari Ini'),
              ],
            ),
          ),
          const SizedBox(height: 10),

          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            child: TabBarView(
              controller: _tabCtrl,
              children: [
                // ── Tab 1: Pilih makanan ──
                _FoodPickerTab(
                  query: _query,
                  searchCtrl: _searchCtrl,
                  results: _results,
                  getQty: _getQty,
                  onQueryChanged: (v) => setState(() => _query = v),
                  onQtyChanged: _setQty,
                  onAdd: (item, qty) {
                    widget.cp.addEntry(
                      item.name,
                      item.caloriesPerServing * qty,
                      date: widget.date,
                      quantity: qty,
                    );
                    setState(() {});
                  },
                  onManual: () {
                    Navigator.pop(context);
                    _showManualDialog(context);
                  },
                  onDeleteCustom: (id) {
                    widget.cp.deleteCustomFood(id);
                    setState(() {});
                  },
                ),
                // ── Tab 2: Log ──
                _DayLogTab(
                  entries: _dateEntries,
                  onDelete: (id) {
                    widget.cp.deleteEntry(id);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: bottomPadding + 8),
        ],
      ),
    );
  }

  void _showManualDialog(BuildContext context) {
    final nameCtrl = TextEditingController();
    final calCtrl = TextEditingController();
    int qty = 1;
    bool saveToList = true;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          backgroundColor: AppTheme.stone100,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          title: Text('Input Manual',
              style: Theme.of(ctx).textTheme.titleLarge),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Nama makanan / minuman',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: calCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Kalori per porsi',
                  suffixText: 'kkal',
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Text('Jumlah:', style: Theme.of(ctx).textTheme.bodyLarge),
                  const Spacer(),
                  _QtyControl(value: qty, onChanged: (v) => setS(() => qty = v)),
                ],
              ),
              const SizedBox(height: 10),
              // Toggle: simpan ke daftar
              InkWell(
                onTap: () => setS(() => saveToList = !saveToList),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: saveToList
                        ? AppTheme.sage200.withValues(alpha: 0.5)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: saveToList
                          ? AppTheme.sage400
                          : AppTheme.stone200,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        saveToList
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_outline_rounded,
                        size: 18,
                        color: saveToList
                            ? AppTheme.sage600
                            : AppTheme.stone400,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Simpan ke daftar makanan saya',
                          style: Theme.of(ctx).textTheme.bodyMedium?.copyWith(
                                color: saveToList
                                    ? AppTheme.sage700
                                    : AppTheme.stone500,
                                fontWeight: saveToList
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (saveToList)
                Padding(
                  padding: const EdgeInsets.only(top: 6, left: 4),
                  child: Text(
                    'Item akan muncul di daftar pencarian berikutnya',
                    style: Theme.of(ctx).textTheme.labelSmall?.copyWith(
                          color: AppTheme.sage600,
                        ),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Batal')),
            ElevatedButton(
              onPressed: () async {
                final name = nameCtrl.text.trim();
                final cal = int.tryParse(calCtrl.text);
                if (name.isNotEmpty && cal != null && cal > 0) {
                  // Simpan ke custom list kalau toggle aktif
                  if (saveToList) {
                    await widget.cp.addCustomFood(name, cal);
                  }
                  // Tambah ke log
                  await widget.cp.addEntry(
                    name,
                    cal * qty,
                    date: widget.date,
                    quantity: qty,
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Food Picker Tab
// ═══════════════════════════════════════════════════════════════
class _FoodPickerTab extends StatelessWidget {
  final String query;
  final TextEditingController searchCtrl;
  final List<SearchableFoodItem> results;
  final int Function(String) getQty;
  final ValueChanged<String> onQueryChanged;
  final void Function(String, int) onQtyChanged;
  final void Function(SearchableFoodItem, int) onAdd;
  final VoidCallback onManual;
  final void Function(String id) onDeleteCustom;

  const _FoodPickerTab({
    required this.query,
    required this.searchCtrl,
    required this.results,
    required this.getQty,
    required this.onQueryChanged,
    required this.onQtyChanged,
    required this.onAdd,
    required this.onManual,
    required this.onDeleteCustom,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar + manual
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: searchCtrl,
                  onChanged: onQueryChanged,
                  decoration: InputDecoration(
                    hintText: 'Cari makanan...',
                    prefixIcon: const Icon(Icons.search_rounded,
                        size: 18, color: AppTheme.stone500),
                    suffixIcon: query.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded,
                                size: 16, color: AppTheme.stone500),
                            onPressed: () => onQueryChanged(''),
                          )
                        : null,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: onManual,
                style: TextButton.styleFrom(
                  backgroundColor: AppTheme.sage100,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text('Manual',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.sage600,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),

        // Section label kalau ada custom
        if (results.any((r) => r.isCustom) && query.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
            child: Row(
              children: [
                const Icon(Icons.bookmark_rounded,
                    size: 12, color: AppTheme.sage600),
                const SizedBox(width: 4),
                Text(
                  'Makanan Saya · ${results.where((r) => r.isCustom).length} item (di bawah daftar bawaan)',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.sage600,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),

        // List
        Expanded(
          child: results.isEmpty
              ? Center(
                  child: Text('Tidak ditemukan.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppTheme.stone500)),
                )
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  itemCount: results.length,
                  separatorBuilder: (_, i) {
                    // Garis pemisah antara preset dan custom
                    final curr = results[i];
                    final next = i + 1 < results.length ? results[i + 1] : null;
                    if (!curr.isCustom && next != null && next.isCustom) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  const Icon(Icons.bookmark_rounded,
                                      size: 11, color: AppTheme.sage500),
                                  const SizedBox(width: 4),
                                  Text('Makanan Saya',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: AppTheme.sage600,
                                            fontWeight: FontWeight.w700,
                                          )),
                                ],
                              ),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                      );
                    }
                    return const SizedBox(height: 4);
                  },
                  itemBuilder: (ctx, i) {
                    final item = results[i];
                    final qty = getQty(item.name);
                    return _FoodItemTile(
                      item: item,
                      qty: qty,
                      onQtyChanged: (v) => onQtyChanged(item.name, v),
                      onAdd: () => onAdd(item, qty),
                      onDeleteCustom: item.isCustom && item.customId != null
                          ? () => onDeleteCustom(item.customId!)
                          : null,
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Food Item Tile (preset + custom)
// ═══════════════════════════════════════════════════════════════
class _FoodItemTile extends StatefulWidget {
  final SearchableFoodItem item;
  final int qty;
  final ValueChanged<int> onQtyChanged;
  final VoidCallback onAdd;
  final VoidCallback? onDeleteCustom;

  const _FoodItemTile({
    required this.item,
    required this.qty,
    required this.onQtyChanged,
    required this.onAdd,
    this.onDeleteCustom,
  });

  @override
  State<_FoodItemTile> createState() => _FoodItemTileState();
}

class _FoodItemTileState extends State<_FoodItemTile> {
  bool _added = false;

  Color _calColor(int cal) {
    if (cal <= 50) return AppTheme.successGreen;
    if (cal <= 150) return AppTheme.sage500;
    if (cal <= 300) return AppTheme.warningAmber;
    return AppTheme.errorRed;
  }

  void _handleAdd() {
    if (_added) return;
    widget.onAdd();
    setState(() => _added = true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _added = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final unitCal = widget.item.caloriesPerServing;
    final totalCal = unitCal * widget.qty;
    final color = _calColor(unitCal);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: _added
            ? AppTheme.sage200.withValues(alpha: 0.5)
            : widget.item.isCustom
                ? AppTheme.sage100.withValues(alpha: 0.6)
                : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _added
              ? AppTheme.sage400
              : widget.item.isCustom
                  ? AppTheme.sage300
                  : AppTheme.stone200,
          width: _added ? 1.5 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 11, 10, 11),
        child: Row(
          children: [
            // Name + badges
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (widget.item.isCustom) ...[
                        const Icon(Icons.bookmark_rounded,
                            size: 12, color: AppTheme.sage500),
                        const SizedBox(width: 4),
                      ],
                      Expanded(
                        child: Text(
                          widget.item.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: color.withValues(alpha: 0.35)),
                        ),
                        child: Text(
                          '$unitCal kkal',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: color),
                        ),
                      ),
                      if (widget.qty > 1) ...[
                        const SizedBox(width: 6),
                        Text(
                          '× ${widget.qty} = $totalCal kkal',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  color: AppTheme.sage600,
                                  fontWeight: FontWeight.w700),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 6),

            // Delete custom (hanya untuk custom food)
            if (widget.onDeleteCustom != null)
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    size: 16, color: AppTheme.stone300),
                onPressed: () => _confirmDeleteCustom(context),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),

            const SizedBox(width: 4),

            // Qty + Add
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _QtyControl(
                    value: widget.qty, onChanged: widget.onQtyChanged),
                const SizedBox(width: 8),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    color: _added ? AppTheme.successGreen : AppTheme.sage600,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: _handleAdd,
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: _added
                              ? const Icon(Icons.check_rounded,
                                  key: ValueKey('check'),
                                  color: Colors.white, size: 22)
                              : const Icon(Icons.add_rounded,
                                  key: ValueKey('add'),
                                  color: Colors.white, size: 22),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeleteCustom(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.stone100,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        title: const Text('Hapus dari daftar?'),
        content: Text(
            '"${widget.item.name}" akan dihapus dari daftar makanan kamu.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Batal')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorRed),
            onPressed: () {
              widget.onDeleteCustom?.call();
              Navigator.pop(ctx);
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Day Log Tab
// ═══════════════════════════════════════════════════════════════
class _DayLogTab extends StatelessWidget {
  final List<CalorieEntry> entries;
  final void Function(String id) onDelete;

  const _DayLogTab({required this.entries, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🍃', style: TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text('Belum ada log untuk hari ini.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppTheme.stone500)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      itemCount: entries.length,
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemBuilder: (ctx, i) {
        final e = entries[entries.length - 1 - i];
        final unitCal =
            e.quantity > 1 ? e.calories ~/ e.quantity : e.calories;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.sage200),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (e.quantity > 1) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.sage500.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('×${e.quantity}',
                                style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: AppTheme.sage600)),
                          ),
                          const SizedBox(width: 6),
                        ],
                        Expanded(
                          child: Text(e.foodName,
                              style: Theme.of(ctx)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      e.quantity > 1
                          ? '$unitCal × ${e.quantity} · ${DateFormat('HH:mm').format(e.date)}'
                          : DateFormat('HH:mm').format(e.date),
                      style: Theme.of(ctx).textTheme.labelSmall,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text('${e.calories} kkal',
                  style: Theme.of(ctx).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.sage600,
                      )),
              const SizedBox(width: 6),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded,
                    size: 18, color: AppTheme.stone400),
                onPressed: () => onDelete(e.id),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Qty Control
// ═══════════════════════════════════════════════════════════════
class _QtyControl extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const _QtyControl({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.sage100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.sage300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(11)),
              onTap: value > 1 ? () => onChanged(value - 1) : null,
              child: SizedBox(
                width: 44, height: 44,
                child: Icon(Icons.remove_rounded, size: 20,
                    color: value > 1
                        ? AppTheme.sage600
                        : AppTheme.stone300),
              ),
            ),
          ),
          SizedBox(
            width: 36,
            child: Center(
              child: Text('$value',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.sage700)),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(11)),
              onTap: () => onChanged(value + 1),
              child: const SizedBox(
                width: 44, height: 44,
                child: Icon(Icons.add_rounded,
                    size: 20, color: AppTheme.sage600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Mini row inside home card
// ═══════════════════════════════════════════════════════════════
class _MiniCalorieRow extends StatelessWidget {
  final CalorieEntry entry;
  final VoidCallback onDelete;
  const _MiniCalorieRow({required this.entry, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(width: 6, height: 6,
              decoration: const BoxDecoration(
                  color: AppTheme.sage400, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              entry.quantity > 1
                  ? '×${entry.quantity} ${entry.foodName}'
                  : entry.foodName,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          Text('${entry.calories} kkal',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppTheme.stone500,
                    fontWeight: FontWeight.w600,
                  )),
          const SizedBox(width: 4),
          Text(DateFormat('HH:mm').format(entry.date),
              style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(width: 4),
          InkWell(
            onTap: onDelete,
            child: const Icon(Icons.close_rounded,
                size: 14, color: AppTheme.stone300),
          ),
        ],
      ),
    );
  }
}

// ── Target button ─────────────────────────────────────────────
class _TargetButton extends StatelessWidget {
  final int target;
  final VoidCallback onTap;
  const _TargetButton({required this.target, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppTheme.sage100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.sage300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.flag_outlined, size: 13, color: AppTheme.sage600),
            const SizedBox(width: 4),
            Text('Target: $target kkal',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppTheme.sage600,
                      fontWeight: FontWeight.w600,
                    )),
          ],
        ),
      ),
    );
  }
}