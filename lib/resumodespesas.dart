import 'package:flutter/material.dart';

import 'config.dart';
import 'dashboard.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResumoDespesasPage(),
    ),
  );
}

class ResumoDespesasPage extends StatefulWidget {
  const ResumoDespesasPage({
    super.key,
    this.categoryLabel = 'Moradia',
    this.icon = Icons.home_outlined,
    this.expenses = const [],
  });

  final String categoryLabel;
  final IconData icon;
  final List<DashboardExpense> expenses;

  static const background = Color(0xFFF0FFF4);
  static const brandGreen = Color(0xCC42AC27);
  static const cardGreen = Color(0xFF2E7D56);
  static const buttonGreen = Color(0xFF68D391);
  static const textDark = Color(0xFF13251D);
  static const textMuted = Color(0xFF607265);
  static const expenseRed = Color(0xFFD00000);
  static const defaultExpenses = [
    DashboardExpense(name: 'Conta de Energia', value: 'R\$ 300,00'),
    DashboardExpense(name: 'Conta de Água', value: 'R\$ 270,00'),
    DashboardExpense(name: 'Registro do chuveiro', value: 'R\$ 50,00'),
  ];

  static double parseCurrency(String value) {
    final normalized = value
        .replaceAll('R\$', '')
        .replaceAll('-', '')
        .replaceAll('.', '')
        .replaceAll(',', '.')
        .trim();

    return double.tryParse(normalized) ?? 0;
  }

  static String formatCurrency(double value) {
    final parts = value.toStringAsFixed(2).split('.');
    final integer = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );

    return 'R\$ $integer,${parts[1]}';
  }

  @override
  State<ResumoDespesasPage> createState() => _ResumoDespesasPageState();
}

class _ResumoDespesasPageState extends State<ResumoDespesasPage> {
  late final List<_EditableExpense> _editableExpenses;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final initialExpenses = widget.expenses.isEmpty
        ? ResumoDespesasPage.defaultExpenses
        : widget.expenses;
    _editableExpenses = initialExpenses
        .map((expense) => _EditableExpense.fromExpense(expense))
        .toList();
  }

  @override
  void dispose() {
    for (final expense in _editableExpenses) {
      expense.dispose();
    }
    super.dispose();
  }

  List<DashboardExpense> get _expenses => _editableExpenses
      .map(
        (expense) => DashboardExpense(
          name: expense.nameController.text.trim(),
          value: _normalizeValue(expense.valueController.text),
        ),
      )
      .where((expense) => expense.name.isNotEmpty)
      .toList();

  String get _totalText {
    final total = _editableExpenses.fold<double>(
      0,
      (total, expense) =>
          total +
          ResumoDespesasPage.parseCurrency(expense.valueController.text),
    );

    return ResumoDespesasPage.formatCurrency(total);
  }

  String _normalizeValue(String value) {
    final trimmedValue = value.trim();
    if (trimmedValue.isEmpty) {
      return 'R\$ 0,00';
    }

    return trimmedValue.startsWith('R\$') ? trimmedValue : 'R\$ $trimmedValue';
  }

  void _syncDashboard() {
    if (widget.expenses.isEmpty) {
      return;
    }

    DashboardPage.updateExpenseCategory(
      label: widget.categoryLabel,
      expenses: _expenses,
    );
  }

  void _normalizeEditedValues() {
    for (final expense in _editableExpenses) {
      expense.valueController.text = _normalizeValue(
        expense.valueController.text,
      );
    }
  }

  void _toggleEditing() {
    if (_isEditing) {
      _normalizeEditedValues();
      _syncDashboard();
    }

    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _deleteExpense(int index) {
    final expense = _editableExpenses.removeAt(index);
    expense.dispose();
    _syncDashboard();
    setState(() {});
  }

  void _deleteGroup() {
    DashboardPage.removeExpenseCategory(widget.categoryLabel);
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const DashboardPage()));
  }

  void _goBack() {
    _syncDashboard();
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const DashboardPage()));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ResumoDespesasPage.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: ResumoDespesasPage.background,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'FinControl',
            style: TextStyle(
              color: ResumoDespesasPage.brandGreen,
              fontSize: width > 400 ? 26 : 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Image.asset(
              'assets/fincontrol-logo.png',
              width: 36,
              height: 36,
              fit: BoxFit.contain,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => const ConfigPage()));
              },
              icon: const Icon(
                Icons.menu,
                color: ResumoDespesasPage.brandGreen,
              ),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                heroTag: 'summaryBack',
                backgroundColor: ResumoDespesasPage.buttonGreen,
                shape: const CircleBorder(),
                elevation: 0,
                onPressed: _goBack,
                child: const Icon(
                  Icons.arrow_back,
                  color: ResumoDespesasPage.textDark,
                  size: 34,
                ),
              ),
              const SizedBox(width: 28),
              FloatingActionButton(
                heroTag: 'summaryEdit',
                backgroundColor: ResumoDespesasPage.buttonGreen,
                shape: const CircleBorder(),
                elevation: 0,
                onPressed: _toggleEditing,
                child: Icon(
                  _isEditing ? Icons.check : Icons.edit,
                  color: ResumoDespesasPage.textDark,
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 6),
                  const CircleAvatar(
                    radius: 47,
                    backgroundImage: AssetImage('assets/perfil.jpeg'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Francisco Duarte',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _TotalSummary(
                    categoryLabel: widget.categoryLabel,
                    totalText: _totalText,
                  ),
                  const SizedBox(height: 18),
                  _ExpenseSummaryCard(
                    categoryLabel: widget.categoryLabel,
                    icon: widget.icon,
                    items: _editableExpenses,
                    isEditing: _isEditing,
                    onChanged: () {
                      _syncDashboard();
                      setState(() {});
                    },
                    onDelete: _deleteExpense,
                    onDeleteGroup: _deleteGroup,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TotalSummary extends StatelessWidget {
  const _TotalSummary({required this.categoryLabel, required this.totalText});

  final String categoryLabel;
  final String totalText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFDDEBDF)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resumo da categoria',
                  style: TextStyle(
                    color: ResumoDespesasPage.textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  categoryLabel,
                  style: const TextStyle(
                    color: ResumoDespesasPage.textDark,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Total gasto',
                style: TextStyle(
                  color: ResumoDespesasPage.textMuted,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                totalText,
                style: const TextStyle(
                  color: ResumoDespesasPage.expenseRed,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ExpenseSummaryCard extends StatelessWidget {
  const _ExpenseSummaryCard({
    required this.categoryLabel,
    required this.icon,
    required this.items,
    required this.isEditing,
    required this.onChanged,
    required this.onDelete,
    required this.onDeleteGroup,
  });

  final String categoryLabel;
  final IconData icon;
  final List<_EditableExpense> items;
  final bool isEditing;
  final VoidCallback onChanged;
  final void Function(int index) onDelete;
  final VoidCallback onDeleteGroup;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      decoration: BoxDecoration(
        color: ResumoDespesasPage.cardGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.white, size: 34),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Despesas de $categoryLabel',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (isEditing) ...[
                const SizedBox(width: 10),
                FloatingActionButton.small(
                  heroTag: null,
                  backgroundColor: ResumoDespesasPage.expenseRed,
                  elevation: 0,
                  shape: const CircleBorder(),
                  onPressed: onDeleteGroup,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
              ],
            ],
          ),
          const SizedBox(height: 16),
          if (items.isEmpty)
            const Text(
              'Nenhuma despesa cadastrada.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )
          else
            for (var i = 0; i < items.length; i++) ...[
              _ExpenseRow(
                expense: items[i],
                isEditing: isEditing,
                onChanged: onChanged,
                onDelete: () => onDelete(i),
              ),
              if (i != items.length - 1) const SizedBox(height: 10),
            ],
        ],
      ),
    );
  }
}

class _ExpenseRow extends StatelessWidget {
  const _ExpenseRow({
    required this.expense,
    required this.isEditing,
    required this.onChanged,
    required this.onDelete,
  });

  final _EditableExpense expense;
  final bool isEditing;
  final VoidCallback onChanged;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    if (isEditing) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.14),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  TextField(
                    controller: expense.nameController,
                    onChanged: (_) => onChanged(),
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    decoration: const InputDecoration(
                      hintText: 'Nome',
                      hintStyle: TextStyle(color: Color(0xFFEAF7EF)),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: expense.valueController,
                    onChanged: (_) => onChanged(),
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    decoration: const InputDecoration(
                      hintText: 'Valor',
                      hintStyle: TextStyle(color: Color(0xFFEAF7EF)),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            FloatingActionButton.small(
              heroTag: null,
              backgroundColor: ResumoDespesasPage.expenseRed,
              elevation: 0,
              shape: const CircleBorder(),
              onPressed: onDelete,
              child: const Icon(Icons.delete, color: Colors.white),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              expense.nameController.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            '-${expense.valueController.text}',
            style: const TextStyle(
              color: Color(0xFFEAF7EF),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _EditableExpense {
  _EditableExpense({required String name, required String value})
    : nameController = TextEditingController(text: name),
      valueController = TextEditingController(text: value);

  factory _EditableExpense.fromExpense(DashboardExpense expense) {
    return _EditableExpense(name: expense.name, value: expense.value);
  }

  final TextEditingController nameController;
  final TextEditingController valueController;

  void dispose() {
    nameController.dispose();
    valueController.dispose();
  }
}
