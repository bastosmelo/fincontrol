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

class ResumoDespesasPage extends StatelessWidget {
  const ResumoDespesasPage({
    super.key,
    this.categoryLabel = 'Moradia',
    this.icon = Icons.home_outlined,
    this.expenses = const [],
  });

  final String categoryLabel;
  final IconData icon;
  final List<DashboardExpense> expenses;

  static const _background = Color(0xFFF0FFF4);
  static const _brandGreen = Color(0xCC42AC27);
  static const _cardGreen = Color(0xFF2E7D56);
  static const _buttonGreen = Color(0xFF68D391);
  static const _textDark = Color(0xFF13251D);
  static const _textMuted = Color(0xFF607265);
  static const _expenseRed = Color(0xFFD00000);
  static const _defaultExpenses = [
    DashboardExpense(name: 'Conta de Energia', value: 'R\$ 300,00'),
    DashboardExpense(name: 'Conta de Água', value: 'R\$ 270,00'),
    DashboardExpense(name: 'Registro do chuveiro', value: 'R\$ 50,00'),
  ];

  static double _parseCurrency(String value) {
    final normalized = value
        .replaceAll('R\$', '')
        .replaceAll('-', '')
        .replaceAll('.', '')
        .replaceAll(',', '.')
        .trim();

    return double.tryParse(normalized) ?? 0;
  }

  static String _formatCurrency(double value) {
    final parts = value.toStringAsFixed(2).split('.');
    final integer = parts[0].replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );

    return 'R\$ $integer,${parts[1]}';
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final displayExpenses = expenses.isEmpty ? _defaultExpenses : expenses;
    final totalText = expenses.isEmpty
        ? 'R\$ 620,00'
        : _formatCurrency(
            displayExpenses.fold<double>(
              0,
              (total, expense) => total + _parseCurrency(expense.value),
            ),
          );

    return Scaffold(
      backgroundColor: _background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: _background,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'FinControl',
            style: TextStyle(
              color: _brandGreen,
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
              icon: const Icon(Icons.menu, color: _brandGreen),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 18),
          child: Center(
            heightFactor: 1,
            child: FloatingActionButton(
              backgroundColor: _buttonGreen,
              shape: const CircleBorder(),
              elevation: 0,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const DashboardPage()),
                );
              },
              child: const Icon(Icons.arrow_back, color: _textDark, size: 34),
            ),
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
                    categoryLabel: categoryLabel,
                    totalText: totalText,
                  ),
                  const SizedBox(height: 18),
                  _DynamicExpenseSummaryCard(
                    categoryLabel: categoryLabel,
                    icon: icon,
                    items: displayExpenses,
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
                    color: ResumoDespesasPage._textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  categoryLabel,
                  style: const TextStyle(
                    color: ResumoDespesasPage._textDark,
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
                  color: ResumoDespesasPage._textMuted,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                totalText,
                style: const TextStyle(
                  color: ResumoDespesasPage._expenseRed,
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

class _DynamicExpenseSummaryCard extends StatelessWidget {
  const _DynamicExpenseSummaryCard({
    required this.categoryLabel,
    required this.icon,
    required this.items,
  });

  final String categoryLabel;
  final IconData icon;
  final List<DashboardExpense> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      decoration: BoxDecoration(
        color: ResumoDespesasPage._cardGreen,
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
            ],
          ),
          const SizedBox(height: 16),
          for (final item in items) ...[
            Container(
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
                      item.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '-${item.value}',
                    style: const TextStyle(
                      color: Color(0xFFEAF7EF),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            if (item != items.last) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class ExpenseSummaryCard extends StatelessWidget {
  const ExpenseSummaryCard({super.key});

  static const _items = [
    _ExpenseItem('Conta de Energia', '-R\$ 300,00'),
    _ExpenseItem('Conta de Água', '-R\$ 270,00'),
    _ExpenseItem('Registro do chuveiro', '-R\$ 50,00'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
      decoration: BoxDecoration(
        color: ResumoDespesasPage._cardGreen,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.home_outlined, color: Colors.white, size: 34),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Despesas da casa',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final item in _items) ...[
            Container(
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
                      item.label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    item.value,
                    style: const TextStyle(
                      color: Color(0xFFEAF7EF),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            if (item != _items.last) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _ExpenseItem {
  const _ExpenseItem(this.label, this.value);

  final String label;
  final String value;
}
