import 'package:flutter/material.dart';

import 'login_app.dart';

void main() {
  runApp(const ConfigApp());
}

class ConfigApp extends StatelessWidget {
  const ConfigApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Configurações',
      home: const ConfigPage(),
    );
  }
}

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  bool perfilExpanded = false;
  bool notificacoesOn = true;

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
          actions: [
            IconButton(
              onPressed: () {},
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
        onPressed: () => Navigator.of(context).maybePop(),
        child: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: SafeArea(
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
                    'Configurações',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width > 400 ? 32 : 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Gerenciamento de perfil (sanfona)
                  buildProfileAccordion(width),
                  const SizedBox(height: 16),

                  buildOptionTile(
                    icon: Icons.security,
                    title: 'Segurança e privacidade',
                    onTap: () {},
                  ),
                  const SizedBox(height: 16),

                  buildSobreAccordion(width),
                  const SizedBox(height: 28),

                  SizedBox(
                    width: width > 360 ? 280 : width * 0.7,
                    height: 46,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF42AC27),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => const LoginAppPage()),
                          (route) => false,
                        );
                      },
                      child: const Text('Sair'),
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

  Widget buildProfileAccordion(double width) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: perfilExpanded,
          onExpansionChanged: (v) => setState(() => perfilExpanded = v),
          leading: Icon(Icons.person, color: const Color(0xCC42AC27)),
          title: const Text(
            'Gerenciamento de perfil',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          children: [
            // Notificações (com switch)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.play_arrow, color: Colors.black),
              title: const Text('Notificações'),
              trailing: Switch.adaptive(
                value: notificacoesOn,
                activeThumbColor: const Color(0xFF68D391),
                activeTrackColor: const Color(0xFFB7F3C6),
                onChanged: (v) => setState(() => notificacoesOn = v),
              ),
              onTap: () => setState(() => notificacoesOn = !notificacoesOn),
            ),
            const Divider(height: 8),
            // Atualizar número de telefone
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.play_arrow, color: Colors.black),
              title: const Text('Atualizar número de telefone'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xCC42AC27)),
              onTap: () {},
            ),
            const Divider(height: 8),
            // Alterar E-mail
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.play_arrow, color: Colors.black),
              title: const Text('Alterar E-mail'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xCC42AC27)),
              onTap: () {},
            ),
            const Divider(height: 8),
            // Excluir conta
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.play_arrow, color: Colors.black),
              title: const Text('Excluir conta'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xCC42AC27)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSobreAccordion(double width) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Icon(Icons.info, color: const Color(0xCC42AC27)),
          title: const Text(
            'Sobre o aplicativo',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.play_arrow, color: Colors.black),
              title: const Text('Versão atual do app'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xCC42AC27)),
              onTap: () {},
            ),
            const Divider(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.play_arrow, color: Colors.black),
              title: const Text('Termos de uso'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xCC42AC27)),
              onTap: () {},
            ),
            const Divider(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.play_arrow, color: Colors.black),
              title: const Text('Política de privacidade'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xCC42AC27)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOptionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xCC42AC27), size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xCC42AC27),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
