import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'senha_enviada.dart';

class RecuperarSenhaPage extends StatefulWidget {
  const RecuperarSenhaPage({super.key});

  @override
  State<RecuperarSenhaPage> createState() => _RecuperarSenhaPageState();
}

class _RecuperarSenhaPageState extends State<RecuperarSenhaPage> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _sendPasswordResetEmail() async {
    if (_emailController.text.trim().isEmpty) {
      _showSnackBar('Por favor, informe seu e-mail.', isError: true);
      return;
    }

    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const SenhaEnviadaPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      _showSnackBar('Erro: ${e.message}', isError: true);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        onPressed: () => Navigator.of(context).maybePop(),
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: SafeArea(
        child: AbsorbPointer(
          absorbing: _isLoading,
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
                      'Recuperar Senha',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: width > 400 ? 32 : 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 28),
                    SizedBox(
                      width: width > 360 ? 340 : width * 0.85,
                      child: TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'e-mail',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF0F0F0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: width > 360 ? 280 : width * 0.7,
                      height: 46,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE0E0E0),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _sendPasswordResetEmail,
                        child: _isLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 3,
                                ),
                              )
                            : const Text('Enviar e-mail de recuperação'),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: width > 360 ? 340 : width * 0.85,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF8EF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.mark_email_read_rounded,
                            color: Color(0xFF68D391),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Confira sua caixa de entrada e também o spam.',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
