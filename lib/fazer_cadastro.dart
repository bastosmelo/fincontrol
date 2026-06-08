import 'package:flutter/material.dart';
import 'cadastro_efetuado.dart';

void main() {
  runApp(const FazerCadastroApp());
}

class FazerCadastroApp extends StatelessWidget {
  const FazerCadastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cadastro',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF0FFF4),
        useMaterial3: true,
      ),
      home: const FazerCadastroPage(),
    );
  }
}

class FazerCadastroPage extends StatelessWidget {
  const FazerCadastroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLarge = width >= 400;
    final fieldWidth = width > 360 ? 340.0 : width * 0.88;

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
            padding: const EdgeInsets.only(left: 12.0),
            child: Image.asset(
              'assets/fincontrol-logo.png',
              width: 36,
              height: 36,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF68D391),
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const LoginPage()),
          );
        },
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'Cadastro',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: isLarge ? 28 : 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildField(width: fieldWidth, hint: 'e-mail'),
                  const SizedBox(height: 16),
                  _buildField(width: fieldWidth, hint: 'repetir e-mail'),
                  const SizedBox(height: 16),
                  _buildField(
                    width: fieldWidth,
                    hint: 'Senha',
                    obscureText: true,
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: fieldWidth,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD9D9D9),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CadastroEfetuadoPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'Efetivar cadastro',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required double width,
    required String hint,
    bool obscureText = false,
  }) {
    return SizedBox(
      width: width,
      height: 56,
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF8E8E8E)),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color(0xFFD9D9D9),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Login Page')));
  }
}
