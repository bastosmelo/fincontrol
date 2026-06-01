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
  const ResumoDespesasPage({super.key});

  static const _background = Color(0xFFF0FFF4);
  static const _brandGreen = Color(0xCC42AC27);
  static const _cardGreen = Color(0xFF2E7D56);
  static const _buttonGreen = Color(0xFF68D391);
  static const _textDark = Color(0xFF13251D);
  static const _textMuted = Color(0xFF607265);
  static const _expenseRed = Color(0xFFD00000);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
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
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(14, 0, 14, 104),
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
                  const _TotalSummary(),
                  const SizedBox(height: 18),
                  const _ExpenseSummaryCard(),
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
  const _TotalSummary();

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
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Resumo da categoria',
                  style: TextStyle(
                    color: ResumoDespesasPage._textMuted,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Moradia',
                  style: TextStyle(
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
              Text(
                'Total gasto',
                style: TextStyle(
                  color: ResumoDespesasPage._textMuted,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'R\$ 620,00',
                style: TextStyle(
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

class _ExpenseSummaryCard extends StatelessWidget {
  const _ExpenseSummaryCard();

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
