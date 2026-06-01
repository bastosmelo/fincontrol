import 'dart:async';

import 'package:flutter/material.dart';

import 'login_app.dart' as login_app;

void main() {
  runApp(const FigmaToCodeApp());
}

class FigmaToCodeApp extends StatelessWidget {
  const FigmaToCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF0FFF4),
      ),
      home: const StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  Timer? _timer;

  static const _background = Color(0xFFF0FFF4);
  static const _textColor = Color(0xFF000000);

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 4), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const login_app.LoginAppPage()),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;
            final logoSize = (width * 0.78).clamp(220.0, 420.0);
            final titleSize = (width * 0.115).clamp(36.0, 64.0);

            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: (width * 0.08).clamp(24.0, 56.0),
                vertical: (height * 0.04).clamp(24.0, 48.0),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Semantics(
                        label: 'Logo FinControl',
                        image: true,
                        child: Image.asset(
                          'assets/fincontrol-logo-2.png',
                          width: logoSize,
                          height: logoSize,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: (height * 0.06).clamp(28.0, 64.0),
                    ),
                    child: Text(
                      'Bem-Vindo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _textColor,
                        fontSize: titleSize,
                        fontWeight: FontWeight.w400,
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
