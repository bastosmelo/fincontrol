import 'package:flutter/material.dart';

import 'adddespesas.dart';
import 'config.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: DashboardPage()),
  );
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const _green = Color(0xFF2E7D32);
  static const _greenLight = Color(0xFFF1F8E9);
  static const _greenMid = Color(0xFF4CAF50);
  static const _bg = Color(0xFFF0FFF4);
  static const _cardBg = Colors.white;
  static const _textDark = Color(0xFF1B2D1C);
  static const _textMuted = Color(0xFF7A8F7B);

  static const _categories = [
    {'icon': Icons.home_outlined, 'label': 'Moradia'},
    {'icon': Icons.build_outlined, 'label': 'Reforma'},
    {'icon': Icons.school_outlined, 'label': 'Educação'},
    {'icon': Icons.pets_outlined, 'label': 'Pets'},
    {'icon': Icons.directions_car_outlined, 'label': 'Transporte'},
    {'icon': Icons.restaurant_outlined, 'label': 'Alimentação'},
    {'icon': Icons.favorite_outline, 'label': 'Saúde'},
    {'icon': Icons.shopping_bag_outlined, 'label': 'Compras'},
    {'icon': Icons.bar_chart_outlined, 'label': 'Relatórios'},
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: _bg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: _bg,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'FinControl',
            style: TextStyle(
              color: const Color(0xCC42AC27),
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
              icon: const Icon(Icons.menu, color: Color(0xCC42AC27)),
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Dashboard',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width > 400 ? 32 : 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 28),
                  _buildProfileSection(),
                  const SizedBox(height: 28),
                  // Passamos o contexto para a função do botão conseguir navegar
                  _buildAddButton(context),
                  const SizedBox(height: 32),
                  _buildCategoriesSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 52,
              backgroundImage: const NetworkImage('https://i.pravatar.cc/300'),
              backgroundColor: _greenLight,
            ),
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: _greenMid,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'Francisco Duarte',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: _textDark,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4),
        Text('Maio de 2026', style: TextStyle(fontSize: 14, color: _textMuted)),
      ],
    );
  }

  // Alterado: Adicionado o parâmetro 'BuildContext context' e o widget InkWell
  Widget _buildAddButton(BuildContext context) {
    return InkWell(
      onTap: () {
        // Envia o usuário para a AddDespesasPage
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Adddespesas()),
        );
      },
      borderRadius: BorderRadius.circular(16), // Efeito visual controlado
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Melhora a área de toque
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _green,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _green.withValues(alpha: 0.35),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add_rounded,
                color: Colors.white,
                size: 34,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Adicionar Despesa',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: _textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categorias',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: _textDark,
          ),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: _categories.length,
          itemBuilder: (context, i) {
            final cat = _categories[i];
            return Container(
              decoration: BoxDecoration(
                color: _cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8EDE8)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: _greenLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      cat['icon'] as IconData,
                      color: _green,
                      size: 20,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    cat['label'] as String,
                    style: const TextStyle(
                      fontSize: 11,
                      color: _textDark,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
