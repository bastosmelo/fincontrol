import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final background = const Color(0xFFEFFFEF);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: () {},
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // small placeholder logo
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 8),
              Center(
                child: CircleAvatar(
                  radius: 56,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Francisco Duarte',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(18),
                      backgroundColor: Colors.green,
                      elevation: 4,
                    ),
                    onPressed: () {},
                    child: const Icon(Icons.add, size: 36, color: Colors.white),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Adicionar\nDespesa',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildIconCircle(Icons.home),
                      _buildIconCircle(Icons.construction),
                      _buildIconCircle(Icons.school),
                      _buildIconCircle(Icons.pets),
                      _buildIconCircle(Icons.directions_car),
                      _emptyCircle(),
                      _emptyCircle(),
                      _emptyCircle(),
                      _buildIconCircle(Icons.bar_chart),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconCircle(IconData icon) => CircleAvatar(
    radius: 30,
    backgroundColor: Colors.white,
    child: Icon(icon, color: Colors.black87, size: 28),
  );

  Widget _emptyCircle() => const CircleAvatar(
    radius: 30,
    backgroundColor: Colors.white,
    child: SizedBox.shrink(),
  );
}
