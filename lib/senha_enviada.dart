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
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, color: Color(0xCC42AC27)),
            ),
            const SizedBox(width: 6),
          ],
        ),
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
                      Align(
                        alignment: Alignment.center,
                        child: Builder(
                          builder: (context) {
                            final buttonSize = width * 0.15;
                            final iconSize = buttonSize * 0.35;

                            return Container(
                              width: buttonSize.clamp(80.0, 130.0),
                              height: buttonSize.clamp(80.0, 130.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF68D391),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: iconSize.clamp(24.0, 40.0),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
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
