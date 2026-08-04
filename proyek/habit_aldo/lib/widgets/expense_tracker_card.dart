import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/expense_entry.dart';
import '../providers/expense_provider.dart';
import '../theme/app_theme.dart';

Color categoryColor(String category) =>
    Color(kCategoryColorHex[category] ?? kCategoryColorHex['Lain-lain']!);

class ExpenseTrackerCard extends StatelessWidget {
  const ExpenseTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(
      builder: (context, ep, _) {
        final total = ep.todayTotal;

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
                    const Text('💸', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 8),
                    Text('Pengeluaran',
                        style: Theme.of(context).textTheme.titleMedium),
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
                          Text(
                            formatRupiah(total),
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    fontSize: 28, color: AppTheme.sage700),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _showAddSheet(context, ep, DateTime.now()),
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

                // ── Today entries (last 4) ──
                if (ep.todayEntries.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  const Divider(height: 1),
                  const SizedBox(height: 6),
                  ...ep.todayEntries.reversed.take(4).map(
                        (e) => _MiniExpenseRow(
                          entry: e,
                          onDelete: () => ep.deleteEntry(e.id),
                        ),
                      ),
                  if (ep.todayEntries.length > 4)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        '+ ${ep.todayEntries.length - 4} item lainnya',
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
                  onPressed: () => _showPastDatePicker(context, ep),
                  icon: const Icon(Icons.edit_calendar_outlined,
                      size: 14, color: AppTheme.sage600),
                  label: Text(
                    'Catat / edit pengeluaran hari lain',
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

  Future<void> _showPastDatePicker(
      BuildContext context, ExpenseProvider ep) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && context.mounted) {
      _showAddSheet(context, ep, picked);
    }
  }

  void _showAddSheet(BuildContext context, ExpenseProvider ep, DateTime date) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddExpenseSheet(ep: ep, date: date),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// Add Expense Bottom Sheet
// ═══════════════════════════════════════════════════════════════
class _AddExpenseSheet extends StatefulWidget {
  final ExpenseProvider ep;
  final DateTime date;
  const _AddExpenseSheet({required this.ep, required this.date});

  @override
  State<_AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends State<_AddExpenseSheet>
    with SingleTickerProviderStateMixin {
  final _searchCtrl = TextEditingController();
  String _query = '';
  late TabController _tabCtrl;

  List<SearchableExpenseItem> get _results => widget.ep.searchItems(_query);

  List<ExpenseEntry> get _dateEntries => widget.ep.entriesForDate(widget.date);
  int get _dateTotal => widget.ep.totalForDate(widget.date);

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
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _tabCtrl.dispose();
    super.dispose();
  }

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
                      Text('Log Pengeluaran',
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
                    formatRupiah(_dateTotal),
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
                Tab(text: 'Pilih Item'),
                Tab(text: 'Log Hari Ini'),
              ],
            ),
          ),
          const SizedBox(height: 10),

          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.55,
            ),
            child: TabBarView(
              controller: _tabCtrl,
              children: [
                // ── Tab 1: Pilih item ──
                _ExpenseItemPickerTab(
                  query: _query,
                  searchCtrl: _searchCtrl,
                  results: _results,
                  onQueryChanged: (v) => setState(() => _query = v),
                  onAdd: (item, amount) {
                    widget.ep.addEntry(
                      item.name,
                      item.category,
                      amount,
                      date: widget.date,
                    );
                    setState(() {});
                  },
                  onManual: () {
                    Navigator.pop(context);
                    _showManualDialog(context);
                  },
                  onDeleteCustom: (id) {
                    widget.ep.deleteCustomItem(id);
                    setState(() {});
                  },
                ),
                // ── Tab 2: Log ──
                _ExpenseDayLogTab(
                  entries: _dateEntries,
                  onDelete: (id) {
                    widget.ep.deleteEntry(id);
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
    final amountCtrl = TextEditingController();
    String category = kExpenseCategories.first;
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
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Nama pengeluaran',
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: category,
                  decoration: const InputDecoration(labelText: 'Kategori'),
                  items: kExpenseCategories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setS(() => category = v ?? category),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: amountCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    labelText: 'Jumlah (ribuan)',
                    suffixText: '× Rp1.000',
                    hintText: 'cth: 25 = Rp25.000',
                  ),
                ),
                const SizedBox(height: 12),
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
                            'Simpan ke daftar item saya',
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
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Item akan muncul di daftar pencarian berikutnya',
                        style: Theme.of(ctx).textTheme.labelSmall?.copyWith(
                              color: AppTheme.sage600,
                            ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Batal')),
            ElevatedButton(
              onPressed: () async {
                final name = nameCtrl.text.trim();
                final ribuan = int.tryParse(amountCtrl.text);
                if (name.isNotEmpty && ribuan != null && ribuan > 0) {
                  final amount = ribuan * 1000;
                  if (saveToList) {
                    await widget.ep.addCustomItem(name, category);
                  }
                  await widget.ep.addEntry(
                    name,
                    category,
                    amount,
                    date: widget.date,
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
// Expense Item Picker Tab
// ═══════════════════════════════════════════════════════════════
class _ExpenseItemPickerTab extends StatelessWidget {
  final String query;
  final TextEditingController searchCtrl;
  final List<SearchableExpenseItem> results;
  final ValueChanged<String> onQueryChanged;
  final void Function(SearchableExpenseItem, int amount) onAdd;
  final VoidCallback onManual;
  final void Function(String id) onDeleteCustom;

  const _ExpenseItemPickerTab({
    required this.query,
    required this.searchCtrl,
    required this.results,
    required this.onQueryChanged,
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
                    hintText: 'Cari item pengeluaran...',
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

        if (results.any((r) => r.isCustom) && query.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
            child: Row(
              children: [
                const Icon(Icons.bookmark_rounded,
                    size: 12, color: AppTheme.sage600),
                const SizedBox(width: 4),
                Text(
                  'Item Saya · ${results.where((r) => r.isCustom).length} item (di bawah daftar bawaan)',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.sage600,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),

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
                                  Text('Item Saya',
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
                    return _ExpenseItemTile(
                      item: item,
                      onAdd: (amount) => onAdd(item, amount),
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
// Expense Item Tile — name + category badge + amount form
// ═══════════════════════════════════════════════════════════════
class _ExpenseItemTile extends StatefulWidget {
  final SearchableExpenseItem item;
  final void Function(int amount) onAdd;
  final VoidCallback? onDeleteCustom;

  const _ExpenseItemTile({
    required this.item,
    required this.onAdd,
    this.onDeleteCustom,
  });

  @override
  State<_ExpenseItemTile> createState() => _ExpenseItemTileState();
}

class _ExpenseItemTileState extends State<_ExpenseItemTile> {
  final _amountCtrl = TextEditingController();
  bool _added = false;

  @override
  void dispose() {
    _amountCtrl.dispose();
    super.dispose();
  }

  void _handleAdd() {
    final ribuan = int.tryParse(_amountCtrl.text);
    if (ribuan == null || ribuan <= 0) return;
    widget.onAdd(ribuan * 1000);
    _amountCtrl.clear();
    setState(() => _added = true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _added = false);
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final color = categoryColor(widget.item.category);

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
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                  ),
                ),
                if (widget.onDeleteCustom != null)
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded,
                        size: 16, color: AppTheme.stone300),
                    onPressed: () => _confirmDeleteCustom(context),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withValues(alpha: 0.35)),
              ),
              child: Text(
                widget.item.category,
                style: TextStyle(
                    fontSize: 11, fontWeight: FontWeight.w700, color: color),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _amountCtrl,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      style: const TextStyle(fontSize: 13),
                      onSubmitted: (_) => _handleAdd(),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Jumlah (ribuan)',
                        hintStyle: const TextStyle(fontSize: 12),
                        suffixText: 'rb',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppTheme.stone200),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: AppTheme.stone200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: AppTheme.sage500),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 44, height: 40,
                  decoration: BoxDecoration(
                    color: _added ? AppTheme.successGreen : AppTheme.sage600,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: _handleAdd,
                      child: Center(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: _added
                              ? const Icon(Icons.check_rounded,
                                  key: ValueKey('check'),
                                  color: Colors.white, size: 20)
                              : const Icon(Icons.add_rounded,
                                  key: ValueKey('add'),
                                  color: Colors.white, size: 20),
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
            '"${widget.item.name}" akan dihapus dari daftar item kamu.'),
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
class _ExpenseDayLogTab extends StatelessWidget {
  final List<ExpenseEntry> entries;
  final void Function(String id) onDelete;

  const _ExpenseDayLogTab({required this.entries, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🧾', style: TextStyle(fontSize: 32)),
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
        final color = categoryColor(e.category);
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
                    Text(e.name,
                        style: Theme.of(ctx)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: color.withValues(alpha: 0.35)),
                          ),
                          child: Text(
                            e.category,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: color),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          DateFormat('HH:mm').format(e.date),
                          style: Theme.of(ctx).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(formatRupiah(e.amount),
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
// Mini row inside home card
// ═══════════════════════════════════════════════════════════════
class _MiniExpenseRow extends StatelessWidget {
  final ExpenseEntry entry;
  final VoidCallback onDelete;
  const _MiniExpenseRow({required this.entry, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final color = categoryColor(entry.category);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(width: 6, height: 6,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              entry.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 6),
          Text(formatRupiah(entry.amount),
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