import 'dart:async';

import 'package:fincontrol/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FinControlApp());
}

class FinControlApp extends StatelessWidget {
  const FinControlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FinControl',
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

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AuthGate())
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final logoSize = (width * 0.78).clamp(220.0, 420.0);
    final titleSize = (width * 0.115).clamp(36.0, 64.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF0FFF4),
      body: SafeArea(
        child: Padding(
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
                    color: Colors.black,
                    fontSize: titleSize,
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      
      if (googleUser == null) {
        return;
      }

      final GoogleSignInAuthentication googleAuth = 
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao fazer login: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFF4),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/fincontrol-logo-2.png',
                  width: (width * 0.5).clamp(150.0, 250.0),
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 40),
                const Text(
                  'FinControl',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Controle suas finanças com eficiência',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF7F8C8D),
                  ),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: (width * 0.7).clamp(200.0, 300.0),
                  child: ElevatedButton.icon(
                    onPressed: () => _signInWithGoogle(context),
                    icon: const Icon(Icons.login),
                    label: const Text(
                      'Entrar com Google',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Use seu e-mail institucional @souunit.com.br',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF95A5A6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF0FFF4),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2C3E50)),
            ),
            SizedBox(height: 16),
            Text(
              'Verificando autenticação...',
              style: TextStyle(
                color: Color(0xFF7F8C8D),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  bool _isEmailValid(String? email) {
    return email != null &&
        email.trim().toLowerCase().endsWith('@souunit.com.br');
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!kIsWeb) {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        }

        if (snapshot.hasData && snapshot.data != null) {
          final User user = snapshot.data!;
          
          if (_isEmailValid(user.email)) {
            return const DashboardPage();
          } else {
            // Executa logout em background
            Future.microtask(() => _signOut());
            return const LoadingPage();
          }
        }
        
        return const LoginPage();
      },
    );
  }
}