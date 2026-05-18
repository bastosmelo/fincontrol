import 'package:flutter/material.dart';

void main() {
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
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.button,
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      initialRoute: AppRoutes.welcome,
      routes: {
        AppRoutes.welcome: (_) => const WelcomeScreen(),
        AppRoutes.login: (_) => const LoginScreen(),
        AppRoutes.signup: (_) => const SignupScreen(),
        AppRoutes.recover: (_) => const RecoverScreen(),
        AppRoutes.dashboard: (_) => const DashboardScreen(),
        AppRoutes.transactions: (_) => const TransactionsScreen(),
        AppRoutes.addTransaction: (_) => const AddTransactionScreen(),
        AppRoutes.budget: (_) => const BudgetScreen(),
        AppRoutes.reports: (_) => const ReportsScreen(),
        AppRoutes.profile: (_) => const ProfileScreen(),
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const FinControlApp();
}

class AppRoutes {
  static const welcome = '/';
  static const login = '/login';
  static const signup = '/signup';
  static const recover = '/recover';
  static const dashboard = '/dashboard';
  static const transactions = '/transactions';
  static const addTransaction = '/add-transaction';
  static const budget = '/budget';
  static const reports = '/reports';
  static const profile = '/profile';
}

class AppAssets {
  static const logo = 'assets/fincontrol-logo.png';
  static const google = 'assets/Google.jpg';
  static const facebook = 'assets/Facebook.jpg';
  static const apple = 'assets/Apple.png';
}

class AppColors {
  static const background = Color(0xFFF0FFF4);
  static const text = Color(0xFF000000);
  static const muted = Color(0xFF2D2D2D);
  static const button = Color(0xFF68D391);
  static const strong = Color(0xFF2F855A);
  static const brand = Color(0xCC42AC27);
  static const line = Color(0xFFD6F5DE);
  static const surface = Colors.white;
}

void go(BuildContext context, String route) {
  Navigator.of(context).pushNamed(route);
}

void replaceWith(BuildContext context, String route) {
  Navigator.of(context).pushReplacementNamed(route);
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 58, this.showName = true});

  final double size;
  final bool showName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          AppAssets.logo,
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
        if (showName) ...[
          const SizedBox(width: 10),
          const Flexible(
            child: Text(
              'FinControl',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.brand,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      showBack: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: BrandMark(size: 48, showName: false),
            ),
            const SizedBox(height: 36),
            const Center(child: BrandMark(size: 118, showName: false)),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'FinControl',
                style: TextStyle(
                  color: AppColors.brand,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Controle suas financas com clareza',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.text,
                fontSize: 32,
                height: 1.05,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Acompanhe gastos, metas, saldo e relatorios em uma rotina simples.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.text,
                fontSize: 16,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 28),
            PrimaryButton(
              label: 'Comecar agora',
              onPressed: () => go(context, AppRoutes.signup),
            ),
            const SizedBox(height: 12),
            SecondaryButton(
              label: 'Ja tenho uma conta',
              onPressed: () => go(context, AppRoutes.login),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      title: 'Entrar',
      subtitle: 'Bem-vindo de volta ao FinControl',
      child: Column(
        children: [
          const InputBox(label: 'E-mail', value: 'franciscoduarte@teste.com'),
          const SizedBox(height: 14),
          const InputBox(label: 'Senha', value: '********', obscure: true),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => go(context, AppRoutes.recover),
              child: const Text(
                'Esqueci minha senha',
                style: TextStyle(
                  color: AppColors.strong,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          PrimaryButton(
            label: 'Acessar conta',
            onPressed: () => replaceWith(context, AppRoutes.dashboard),
          ),
          const SizedBox(height: 18),
          const DividerRow(),
          const SizedBox(height: 18),
          const SocialButtons(),
          const SizedBox(height: 18),
          TextButton(
            onPressed: () => go(context, AppRoutes.signup),
            child: const Text(
              'Criar uma nova conta',
              style: TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      title: 'Criar conta',
      subtitle: 'Organize seu dinheiro em poucos minutos',
      child: Column(
        children: [
          const InputBox(label: 'Nome', value: 'Francisco Duarte'),
          const SizedBox(height: 14),
          const InputBox(label: 'E-mail', value: 'franciscoduarte@teste.com'),
          const SizedBox(height: 14),
          const InputBox(label: 'Senha', value: '********', obscure: true),
          const SizedBox(height: 18),
          PrimaryButton(
            label: 'Cadastrar',
            onPressed: () => replaceWith(context, AppRoutes.dashboard),
          ),
          const SizedBox(height: 18),
          const DividerRow(),
          const SizedBox(height: 18),
          const SocialButtons(),
          const SizedBox(height: 18),
          TextButton(
            onPressed: () => go(context, AppRoutes.login),
            child: const Text(
              'Ja tenho uma conta',
              style: TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RecoverScreen extends StatelessWidget {
  const RecoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthShell(
      title: 'Recuperar senha',
      subtitle: 'Enviaremos um codigo para redefinir seu acesso',
      child: Column(
        children: [
          const InputBox(label: 'E-mail', value: 'franciscoduarte@teste.com'),
          const SizedBox(height: 20),
          PrimaryButton(
            label: 'Enviar codigo',
            onPressed: () => go(context, AppRoutes.login),
          ),
          const SizedBox(height: 20),
          InfoBox(
            icon: Icons.mark_email_read_rounded,
            text: 'Confira sua caixa de entrada e tambem o spam.',
          ),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainShell(
      title: 'Ola, Francisco',
      subtitle: 'Resumo de maio',
      selectedIndex: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const BalanceCard(),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: MetricCard(
                  icon: Icons.arrow_downward_rounded,
                  label: 'Entradas',
                  value: 'R\$ 8.240',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MetricCard(
                  icon: Icons.arrow_upward_rounded,
                  label: 'Saidas',
                  value: 'R\$ 3.190',
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const SectionTitle(title: 'Acoes rapidas'),
          const SizedBox(height: 12),
          QuickActions(
            actions: [
              QuickAction(
                Icons.add_rounded,
                'Adicionar',
                () => go(context, AppRoutes.addTransaction),
              ),
              QuickAction(
                Icons.receipt_long_rounded,
                'Gastos',
                () => go(context, AppRoutes.transactions),
              ),
              QuickAction(
                Icons.pie_chart_rounded,
                'Resumo',
                () => go(context, AppRoutes.reports),
              ),
              QuickAction(
                Icons.person_rounded,
                'Perfil',
                () => go(context, AppRoutes.profile),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SectionTitle(title: 'Ultimas transacoes'),
          const SizedBox(height: 10),
          for (final transaction in sampleTransactions.take(4))
            TransactionTile(transaction: transaction),
        ],
      ),
    );
  }
}

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainShell(
      title: 'Transacoes',
      subtitle: 'Historico e filtros',
      selectedIndex: 1,
      trailing: IconButton(
        tooltip: 'Adicionar',
        onPressed: () => go(context, AppRoutes.addTransaction),
        icon: const Icon(Icons.add_rounded),
      ),
      child: Column(
        children: [
          const SearchBox(),
          const SizedBox(height: 16),
          const SegmentTabs(labels: ['Todas', 'Entradas', 'Saidas']),
          const SizedBox(height: 18),
          for (final transaction in sampleTransactions)
            TransactionTile(transaction: transaction),
        ],
      ),
    );
  }
}

class AddTransactionScreen extends StatelessWidget {
  const AddTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainShell(
      title: 'Nova transacao',
      subtitle: 'Registre uma entrada ou saida',
      selectedIndex: 1,
      child: Column(
        children: [
          const SegmentTabs(labels: ['Despesa', 'Receita']),
          const SizedBox(height: 18),
          const InputBox(label: 'Descricao', value: 'Mercado semanal'),
          const SizedBox(height: 14),
          const InputBox(label: 'Valor', value: 'R\$ 248,90'),
          const SizedBox(height: 14),
          const InputBox(label: 'Categoria', value: 'Alimentacao'),
          const SizedBox(height: 14),
          const InputBox(label: 'Data', value: '10 maio 2026'),
          const SizedBox(height: 22),
          PrimaryButton(
            label: 'Salvar transacao',
            onPressed: () => replaceWith(context, AppRoutes.transactions),
          ),
        ],
      ),
    );
  }
}

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainShell(
      title: 'Orcamento',
      subtitle: 'Limites por categoria',
      selectedIndex: 2,
      child: Column(
        children: [
          const BudgetSummary(),
          const SizedBox(height: 18),
          for (final item in sampleBudgets)
            ProgressTile(
              title: item.title,
              subtitle: item.subtitle,
              value: item.value,
            ),
        ],
      ),
    );
  }
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainShell(
      title: 'Relatorios',
      subtitle: 'Analise dos seus gastos',
      selectedIndex: 2,
      child: const Column(
        children: [
          ReportChart(),
          SizedBox(height: 18),
          SectionTitle(title: 'Categorias'),
          SizedBox(height: 12),
          CategorySpend(label: 'Moradia', value: '35%'),
          CategorySpend(label: 'Alimentacao', value: '24%'),
          CategorySpend(label: 'Transporte', value: '18%'),
          CategorySpend(label: 'Lazer', value: '12%'),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainShell(
      title: 'Perfil',
      subtitle: 'Conta e preferencias',
      selectedIndex: 3,
      child: Column(
        children: [
          const ProfileHeader(),
          const SizedBox(height: 20),
          const SettingsRow(
            icon: Icons.lock_outline_rounded,
            label: 'Seguranca',
          ),
          const SettingsRow(
            icon: Icons.account_balance_rounded,
            label: 'Contas conectadas',
          ),
          const SettingsRow(
            icon: Icons.notifications_none_rounded,
            label: 'Notificacoes',
          ),
          const SettingsRow(icon: Icons.palette_outlined, label: 'Aparencia'),
          const SettingsRow(icon: Icons.help_outline_rounded, label: 'Ajuda'),
          const SizedBox(height: 18),
          SecondaryButton(
            label: 'Sair da conta',
            onPressed: () => replaceWith(context, AppRoutes.welcome),
          ),
        ],
      ),
    );
  }
}

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child, this.showBack = true});

  final Widget child;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showBack)
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
                ),
              Expanded(
                child: DefaultTextStyle.merge(
                  textAlign: TextAlign.center,
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthShell extends StatelessWidget {
  const AuthShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const BrandMark(size: 50),
            const SizedBox(height: 44),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 15,
                height: 1.35,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 32),
            child,
          ],
        ),
      ),
    );
  }
}

class MainShell extends StatelessWidget {
  const MainShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.selectedIndex,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final int selectedIndex;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
              child: Row(
                children: [
                  const BrandMark(size: 38, showName: false),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.text,
                            fontSize: 23,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          subtitle,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.text,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ?trailing,
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 22),
                child: DefaultTextStyle.merge(
                  textAlign: TextAlign.center,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: FinBottomBar(selectedIndex: selectedIndex),
    );
  }
}

class FinBottomBar extends StatelessWidget {
  const FinBottomBar({super.key, required this.selectedIndex});

  final int selectedIndex;

  static const routes = [
    AppRoutes.dashboard,
    AppRoutes.transactions,
    AppRoutes.budget,
    AppRoutes.profile,
  ];

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.home_rounded, 'Home'),
      (Icons.receipt_long_rounded, 'Gastos'),
      (Icons.pie_chart_rounded, 'Resumo'),
      (Icons.person_rounded, 'Perfil'),
    ];

    return NavigationBar(
      selectedIndex: selectedIndex,
      backgroundColor: Colors.white,
      indicatorColor: AppColors.background,
      onDestinationSelected: (index) {
        if (index != selectedIndex) {
          replaceWith(context, routes[index]);
        }
      },
      destinations: [
        for (final item in items)
          NavigationDestination(icon: Icon(item.$1), label: item.$2),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.button,
          foregroundColor: AppColors.text,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.text,
          side: const BorderSide(color: AppColors.strong),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SocialButton(asset: AppAssets.google, label: 'Google'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SocialButton(asset: AppAssets.facebook, label: 'Facebook'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SocialButton(asset: AppAssets.apple, label: 'Apple'),
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.asset, required this.label});

  final String asset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => replaceWith(context, AppRoutes.dashboard),
        child: Container(
          height: 52,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.line),
          ),
          child: Image.asset(asset, fit: BoxFit.contain),
        ),
      ),
    );
  }
}

class DividerRow extends StatelessWidget {
  const DividerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: AppColors.line)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'ou',
            style: TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(child: Container(height: 1, color: AppColors.line)),
      ],
    );
  }
}

class InputBox extends StatelessWidget {
  const InputBox({
    super.key,
    required this.label,
    required this.value,
    this.obscure = false,
  });

  final String label;
  final String value;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (obscure)
                const Icon(
                  Icons.visibility_off_outlined,
                  color: AppColors.text,
                  size: 18,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.strong,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.strong,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Saldo total',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'R\$ 24.860,00',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Icon(Icons.trending_up_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                '+12,4% vs. mes anterior',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.strong,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  label,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  value,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuickAction {
  const QuickAction(this.icon, this.label, this.onTap);

  final IconData icon;
  final String label;
  final VoidCallback onTap;
}

class QuickActions extends StatelessWidget {
  const QuickActions({super.key, required this.actions});

  final List<QuickAction> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final action in actions)
          InkWell(
            onTap: action.onTap,
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 76,
              child: Column(
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: AppColors.strong,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(action.icon, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    action.label,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.text,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const Text(
          'Ver tudo',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.strong,
            fontWeight: FontWeight.w900,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
      ),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, color: AppColors.text),
          SizedBox(width: 10),
          Text(
            'Buscar transacao',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class SegmentTabs extends StatelessWidget {
  const SegmentTabs({super.key, required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.strong,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: Container(
                height: 38,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: i == 0 ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  labels[i],
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: i == 0 ? AppColors.text : Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.transaction});

  final TransactionData transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(transaction.icon, color: AppColors.strong),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  transaction.title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  transaction.category,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            transaction.amount,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class BudgetSummary extends StatelessWidget {
  const BudgetSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.strong,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 84,
            height: 84,
            child: CircularProgressIndicator(
              value: 0.64,
              strokeWidth: 10,
              backgroundColor: AppColors.background,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '64% usado',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'R\$ 3.190 de R\$ 5.000 planejados para maio.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressTile extends StatelessWidget {
  const ProgressTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
  });

  final String title;
  final String subtitle;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                '${(value * 100).round()}%',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.strong,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.text),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 9,
              color: AppColors.strong,
              backgroundColor: AppColors.background,
            ),
          ),
        ],
      ),
    );
  }
}

class ReportChart extends StatelessWidget {
  const ReportChart({super.key});

  @override
  Widget build(BuildContext context) {
    final bars = [0.44, 0.62, 0.48, 0.77, 0.52, 0.86, 0.66];
    final labels = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D'];

    return Container(
      height: 220,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Gastos na semana',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.text,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (var i = 0; i < bars.length; i++)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: FractionallySizedBox(
                              heightFactor: bars[i],
                              widthFactor: 0.48,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: i == 5
                                      ? AppColors.strong
                                      : AppColors.background,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          labels[i],
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.text),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategorySpend extends StatelessWidget {
  const CategorySpend({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: AppColors.strong,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.strong,
              size: 34,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Francisco Duarte',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'franciscoduarte@teste.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsRow extends StatelessWidget {
  const SettingsRow({super.key, required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.strong),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.text),
        ],
      ),
    );
  }
}

class TransactionData {
  const TransactionData({
    required this.title,
    required this.category,
    required this.amount,
    required this.icon,
  });

  final String title;
  final String category;
  final String amount;
  final IconData icon;
}

class BudgetData {
  const BudgetData({
    required this.title,
    required this.subtitle,
    required this.value,
  });

  final String title;
  final String subtitle;
  final double value;
}

const sampleTransactions = [
  TransactionData(
    title: 'Salario',
    category: 'Receita',
    amount: '+R\$ 8.240',
    icon: Icons.work_rounded,
  ),
  TransactionData(
    title: 'Mercado Bom Preco',
    category: 'Alimentacao',
    amount: '-R\$ 248,90',
    icon: Icons.shopping_cart_rounded,
  ),
  TransactionData(
    title: 'Apartamento',
    category: 'Moradia',
    amount: '-R\$ 1.680',
    icon: Icons.home_rounded,
  ),
  TransactionData(
    title: 'Uber',
    category: 'Transporte',
    amount: '-R\$ 42,70',
    icon: Icons.local_taxi_rounded,
  ),
  TransactionData(
    title: 'Freelance',
    category: 'Receita extra',
    amount: '+R\$ 1.200',
    icon: Icons.laptop_mac_rounded,
  ),
  TransactionData(
    title: 'Cinema',
    category: 'Lazer',
    amount: '-R\$ 78,00',
    icon: Icons.movie_rounded,
  ),
];

const sampleBudgets = [
  BudgetData(title: 'Moradia', subtitle: 'R\$ 1.680 de R\$ 1.900', value: 0.88),
  BudgetData(
    title: 'Alimentacao',
    subtitle: 'R\$ 740 de R\$ 1.100',
    value: 0.67,
  ),
  BudgetData(title: 'Transporte', subtitle: 'R\$ 290 de R\$ 500', value: 0.58),
  BudgetData(title: 'Lazer', subtitle: 'R\$ 480 de R\$ 600', value: 0.80),
];
