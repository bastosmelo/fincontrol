import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config.dart';
import 'dashboard.dart';

void main() {
  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: Adddespesas()),
  );
}

class Adddespesas extends StatelessWidget {
  const Adddespesas({super.key});

  @override
  Widget build(BuildContext context) => const ExpenseFormScreen();
}

class ExpenseFormScreen extends StatefulWidget {
  const ExpenseFormScreen({super.key});

  @override
  State<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends State<ExpenseFormScreen> {
  bool _isIconMenuOpen = false;
  IconData _selectedIcon = Icons.home;

  final List<IconData> _iconsList = [
    Icons.home,
    Icons.build,
    Icons.school,
    Icons.pets,
    Icons.directions_car,
    Icons.restaurant,
    Icons.favorite,
    Icons.shopping_bag,
    Icons.insert_chart,
  ];

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF2E7D56);
    const inputTextColor = Color(0xFF1E3A2B);
    const actionButtonColor = Color(0xFF62D397);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFF0FFF4),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          backgroundColor: const Color(0xFFF0FFF4),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF68D391),
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const DashboardPage()),
          );
        },
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Foto de Perfil
              Center(
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=400',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Nome do usuário
              const Text(
                'Francisco Duarte',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),

              // Seção do Grupo
              Container(
                decoration: BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: TextField(
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Grupo',
                                hintStyle: TextStyle(
                                  color: inputTextColor,
                                  fontSize: 18,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isIconMenuOpen = !_isIconMenuOpen;
                              });
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                _selectedIcon,
                                color: primaryGreen,
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      height: _isIconMenuOpen ? 80.0 : 0.0,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Color(0xFF235E41),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(12),
                        ),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
                        itemCount: _iconsList.length,
                        itemBuilder: (context, index) {
                          final icon = _iconsList[index];
                          final isSelected = _selectedIcon == icon;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIcon = icon;
                                _isIconMenuOpen = false;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white24
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                icon,
                                color: isSelected
                                    ? actionButtonColor
                                    : Colors.white,
                                size: 28,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Campo: Nome da despesa
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Nome da despesa',
                    hintStyle: TextStyle(color: inputTextColor, fontSize: 18),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Campo: Valor da despesa
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: primaryGreen,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CurrencyInputFormatter(),
                  ],
                  decoration: const InputDecoration(
                    hintText: 'Valor da despesa',
                    hintStyle: TextStyle(color: inputTextColor, fontSize: 18),
                    border: InputBorder.none,
                    prefixText: 'R\$ ',
                    prefixStyle: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Botão de Confirmação (Check)
              FloatingActionButton(
                heroTag: 'confirmExpense',
                backgroundColor: const Color(0xFF68D391),
                shape: const CircleBorder(),
                onPressed: () {},
                child: const Icon(Icons.check, color: Colors.white),
              ),
              const SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}

// Formatador de Moeda (Ponto e Vírgula) manual
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String digitsOnly = newValue.text;
    double value = double.parse(digitsOnly) / 100;
    String text = value.toStringAsFixed(2);

    List<String> parts = text.split('.');
    String inteira = parts[0];
    String centavos = parts[1];

    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    inteira = inteira.replaceAllMapped(reg, (Match match) => '${match[1]}.');

    String newText = '$inteira,$centavos';

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
