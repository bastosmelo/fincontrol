import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DashboardPage(),
  ));
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const _green = Color(0xFF2E7D32);
  static const _greenLight = Color(0xFFF1F8E9);
  static const _greenMid = Color(0xFF4CAF50);
  static const _bg = Color(0xFFF8FAF8);
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
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              _buildProfileSection(),
              const SizedBox(height: 28),
              _buildAddButton(),
              const SizedBox(height: 32),
              _buildCategoriesSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: _green,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'FinControl',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: _textDark,
                letterSpacing: -0.3,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _headerIconBtn(Icons.notifications_outlined),
            const SizedBox(width: 6),
            _headerIconBtn(Icons.logout_outlined),
          ],
        ),
      ],
    );
  }

  Widget _headerIconBtn(IconData icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE8EDE8)),
      ),
      child: Icon(icon, size: 18, color: _textMuted),
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
        Text(
          'Maio de 2026',
          style: TextStyle(
            fontSize: 14,
            color: _textMuted,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: _greenLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Pro',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _green,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: _green,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: _green.withOpacity(0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.add_rounded, color: Colors.white, size: 34),
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
    );
  }

  Widget _buildCategoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Categorias',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: _textDark,
              ),
            ),
            Text(
              'Ver todas',
              style: TextStyle(
                fontSize: 13,
                color: _green,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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
                    child: Icon(cat['icon'] as IconData, color: _green, size: 20),
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