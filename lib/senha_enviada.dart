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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFF68D391),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'FinControl',
                    style: TextStyle(
                      color: Color(0xCC42AC27),
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  if (isLarge)
                    const Icon(
                      Icons.more_vert,
                      color: Colors.black54,
                    ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),
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
                    Builder(
                      builder: (context) {
                        final buttonSize = width * 0.35;
                        final iconSize = buttonSize * 0.32;

                        return Container(
                          width: buttonSize.clamp(100.0, 220.0),
                          height: buttonSize.clamp(100.0, 220.0),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF68D391),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: iconSize.clamp(32.0, 72.0),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
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
