import 'package:fincontrol/fazer_cadastro.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const SenhaEnviadaApp());
}

class SenhaEnviadaApp extends StatelessWidget {
  const SenhaEnviadaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Senha Enviada',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF0FFF4),
        useMaterial3: true,
      ),
      home: const SenhaEnviadaPage(),
    );
  }
}

class SenhaEnviadaPage extends StatelessWidget {
  const SenhaEnviadaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isLarge = width >= 400;

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
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
            (route) => false,
          );
        },
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Senha enviada com sucesso',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: isLarge ? 32 : 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Confira seu e-mail para recuperar o acesso à sua conta.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF6B6B6B),
                          fontSize: 16,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 42),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
