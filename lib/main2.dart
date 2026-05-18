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
        scaffoldBackgroundColor: AppColors.canvas,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
        fontFamily: 'DM Sans',
      ),
      home: const DesignGallery(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const FinControlApp();
}

class AppColors {
  static const canvas = Color(0xFFF0FFF4);
  static const ink = Color(0xFF000000);
  static const muted = Color(0xFF000000);
  static const primary = Color(0xFF68D391);
  static const primaryDark = Color(0xFF2F855A);
  static const brandName = Color(0xCC42AC27);
  static const success = Color(0xFF2F855A);
  static const danger = Color(0xFF2F855A);
  static const warning = Color(0xFF68D391);
  static const line = Color(0xFFD6F5DE);
  static const card = Colors.white;
}

class DesignGallery extends StatefulWidget {
  const DesignGallery({super.key});

  @override
  State<DesignGallery> createState() => _DesignGalleryState();
}

class _DesignGalleryState extends State<DesignGallery> {
  final PageController _pageController = PageController();
  int _index = 0;

  late final List<FinScreen> _screens = [
    FinScreen('Splash', const SplashScreen()),
    FinScreen('Boas-vindas', const WelcomeScreen()),
    FinScreen('Entrar', const LoginScreen()),
    FinScreen('Cadastro', const SignUpScreen()),
    FinScreen('Recuperar', const RecoverScreen()),
    FinScreen('Home', const DashboardScreen()),
    FinScreen('Transacoes', const TransactionsScreen()),
    FinScreen('Nova transacao', const AddTransactionScreen()),
    FinScreen('Orcamento', const BudgetScreen()),
    FinScreen('Metas', const GoalsScreen()),
    FinScreen('Cartoes', const CardsScreen()),
    FinScreen('Relatorios', const ReportsScreen()),
    FinScreen('Perfil', const ProfileScreen()),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    setState(() => _index = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.sizeOf(context).width >= 760;

    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            if (wide)
              ScreenRail(
                screens: _screens,
                selected: _index,
                onSelected: _goTo,
              ),
            Expanded(
              child: Column(
                children: [
                  if (!wide)
                    MobileScreenTabs(
                      screens: _screens,
                      selected: _index,
                      onSelected: _goTo,
                    ),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (value) => setState(() => _index = value),
                      itemCount: _screens.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: PhoneFrame(child: _screens[index].child),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinScreen {
  const FinScreen(this.title, this.child);

  final String title;
  final Widget child;
}

class ScreenRail extends StatelessWidget {
  const ScreenRail({
    super.key,
    required this.screens,
    required this.selected,
    required this.onSelected,
  });

  final List<FinScreen> screens;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 236,
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: AppColors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BrandMark(compact: false),
          const SizedBox(height: 22),
          Expanded(
            child: ListView.separated(
              itemCount: screens.length,
              separatorBuilder: (_, _) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final active = index == selected;
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => onSelected(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: active ? AppColors.canvas : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '${index + 1}'.padLeft(2, '0'),
                          style: TextStyle(
                            color: active ? AppColors.primary : AppColors.muted,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            screens[index].title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: active ? AppColors.ink : AppColors.muted,
                              fontWeight: active
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MobileScreenTabs extends StatelessWidget {
  const MobileScreenTabs({
    super.key,
    required this.screens,
    required this.selected,
    required this.onSelected,
  });

  final List<FinScreen> screens;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        scrollDirection: Axis.horizontal,
        itemCount: screens.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final active = index == selected;
          return ChoiceChip(
            selected: active,
            onSelected: (_) => onSelected(index),
            label: Text('${index + 1}. ${screens[index].title}'),
            selectedColor: AppColors.canvas,
            side: BorderSide(
              color: active ? AppColors.primary : AppColors.line,
            ),
            showCheckmark: false,
          );
        },
      ),
    );
  }
}

class PhoneFrame extends StatelessWidget {
  const PhoneFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.clamp(320.0, 420.0).toDouble();
        final height = constraints.maxHeight.clamp(560.0, 860.0).toDouble();
        return Container(
          width: width,
          height: height,
          margin: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.canvas,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFD1D5DB), width: 6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.10),
                blurRadius: 32,
                offset: const Offset(0, 18),
              ),
            ],
          ),
          child: child,
        );
      },
    );
  }
}

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
    this.actions,
    this.bottomBarIndex,
    this.padded = true,
  });

  final String title;
  final String? subtitle;
  final Widget child;
  final List<Widget>? actions;
  final int? bottomBarIndex;
  final bool padded;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.ink,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                ...?actions,
              ],
            ),
          ),
          Expanded(
            child: padded
                ? SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                    child: child,
                  )
                : child,
          ),
        ],
      ),
      bottomNavigationBar: bottomBarIndex == null
          ? null
          : FinBottomBar(index: bottomBarIndex!),
    );
  }
}

class FinBottomBar extends StatelessWidget {
  const FinBottomBar({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.home_rounded, 'Home'),
      (Icons.receipt_long_rounded, 'Gastos'),
      (Icons.pie_chart_rounded, 'Resumo'),
      (Icons.person_rounded, 'Perfil'),
    ];

    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (var i = 0; i < items.length; i++)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  items[i].$1,
                  color: i == index ? AppColors.primary : AppColors.muted,
                ),
                const SizedBox(height: 4),
                Text(
                  items[i].$2,
                  style: TextStyle(
                    color: i == index ? AppColors.primary : AppColors.muted,
                    fontSize: 11,
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

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.compact = true, this.size = 42});

  final bool compact;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'fincontrol-logo.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
        if (!compact) ...[
          const SizedBox(width: 10),
          const Flexible(
            child: Text(
              'FinControl',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.brandName,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.canvas,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BrandMark(size: 138),
          SizedBox(height: 18),
          Text(
            'FinControl',
            style: TextStyle(
              color: AppColors.brandName,
              fontSize: 34,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Seu dinheiro em ordem',
            style: TextStyle(
              color: AppColors.ink,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF68D391),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(alignment: Alignment.topRight, child: BrandMark()),
            const Spacer(),
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.canvas,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 28,
                    right: 28,
                    top: 42,
                    child: Container(
                      height: 118,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            blurRadius: 28,
                            offset: const Offset(0, 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 56,
                    top: 70,
                    child: Icon(
                      Icons.show_chart_rounded,
                      color: AppColors.primary,
                      size: 92,
                    ),
                  ),
                  const Positioned(
                    right: 54,
                    bottom: 46,
                    child: Icon(
                      Icons.savings_rounded,
                      color: AppColors.success,
                      size: 58,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Controle suas financas com clareza',
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 30,
                height: 1.05,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Acompanhe gastos, crie metas e visualize seu saldo em uma rotina simples.',
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 15,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 28),
            const PrimaryButton(label: 'Comecar agora'),
            const SizedBox(height: 12),
            const SecondaryButton(label: 'Ja tenho uma conta'),
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
    return AuthScaffold(
      title: 'Entrar',
      subtitle: 'Bem-vindo de volta ao FinControl',
      child: Column(
        children: [
          const InputBox(label: 'E-mail', value: 'ana@email.com'),
          const SizedBox(height: 14),
          const InputBox(label: 'Senha', value: '••••••••', obscure: true),
          const SizedBox(height: 10),
          const Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Esqueci minha senha',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const PrimaryButton(label: 'Acessar conta'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Container(height: 1, color: AppColors.line)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('ou', style: TextStyle(color: AppColors.muted)),
              ),
              Expanded(child: Container(height: 1, color: AppColors.line)),
            ],
          ),
          const SizedBox(height: 16),
          const SecondaryButton(
            label: 'Entrar com Google',
            icon: Icons.g_mobiledata,
          ),
        ],
      ),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      title: 'Criar conta',
      subtitle: 'Organize seu dinheiro em poucos minutos',
      child: const Column(
        children: [
          InputBox(label: 'Nome', value: 'Ana Martins'),
          SizedBox(height: 14),
          InputBox(label: 'E-mail', value: 'ana@email.com'),
          SizedBox(height: 14),
          InputBox(label: 'Senha', value: '••••••••', obscure: true),
          SizedBox(height: 20),
          PrimaryButton(label: 'Cadastrar'),
          SizedBox(height: 14),
          Text(
            'Ao continuar, voce aceita os termos de uso.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.muted, fontSize: 12),
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
    return AuthScaffold(
      title: 'Recuperar senha',
      subtitle: 'Enviaremos um codigo para redefinir seu acesso',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InputBox(label: 'E-mail', value: 'ana@email.com'),
          const SizedBox(height: 20),
          const PrimaryButton(label: 'Enviar codigo'),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryDark,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                Icon(Icons.mark_email_read_rounded, color: Colors.white),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Confira sua caixa de entrada e tambem o spam.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
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

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const BrandMark(compact: false),
            const SizedBox(height: 52),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 31,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                color: AppColors.muted,
                fontSize: 15,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 34),
            child,
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Ola, Ana',
      subtitle: 'Resumo de maio',
      bottomBarIndex: 0,
      actions: const [CircleIcon(icon: Icons.notifications_none_rounded)],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BalanceCard(),
          const SizedBox(height: 18),
          const Row(
            children: [
              Expanded(
                child: MetricTile(
                  icon: Icons.arrow_downward_rounded,
                  label: 'Entradas',
                  value: 'R\$ 8.240',
                  color: AppColors.success,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: MetricTile(
                  icon: Icons.arrow_upward_rounded,
                  label: 'Saidas',
                  value: 'R\$ 3.190',
                  color: AppColors.danger,
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const SectionTitle(title: 'Acoes rapidas'),
          const SizedBox(height: 12),
          const QuickActions(),
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
    return AppShell(
      title: 'Transacoes',
      subtitle: 'Historico e filtros',
      bottomBarIndex: 1,
      actions: const [CircleIcon(icon: Icons.tune_rounded)],
      child: Column(
        children: [
          const SearchBarMock(),
          const SizedBox(height: 16),
          const SegmentedMock(labels: ['Todas', 'Entradas', 'Saidas']),
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
    return AppShell(
      title: 'Nova transacao',
      subtitle: 'Registre uma entrada ou saida',
      child: const Column(
        children: [
          SegmentedMock(labels: ['Despesa', 'Receita']),
          SizedBox(height: 18),
          InputBox(label: 'Descricao', value: 'Mercado semanal'),
          SizedBox(height: 14),
          InputBox(label: 'Valor', value: 'R\$ 248,90'),
          SizedBox(height: 14),
          InputBox(label: 'Categoria', value: 'Alimentacao'),
          SizedBox(height: 14),
          InputBox(label: 'Data', value: '10 maio 2026'),
          SizedBox(height: 20),
          CategoryGrid(),
          SizedBox(height: 24),
          PrimaryButton(label: 'Salvar transacao'),
        ],
      ),
    );
  }
}

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Orcamento',
      subtitle: 'Limites por categoria',
      bottomBarIndex: 2,
      child: Column(
        children: [
          const BudgetSummary(),
          const SizedBox(height: 18),
          for (final item in sampleBudgets)
            ProgressTile(
              title: item.title,
              subtitle: item.subtitle,
              value: item.value,
              color: item.color,
            ),
        ],
      ),
    );
  }
}

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Metas',
      subtitle: 'Objetivos financeiros',
      actions: const [CircleIcon(icon: Icons.add_rounded)],
      child: Column(
        children: const [
          GoalCard(
            icon: Icons.flight_takeoff_rounded,
            title: 'Viagem para Lisboa',
            saved: 'R\$ 6.800',
            target: 'R\$ 12.000',
            progress: 0.57,
            color: AppColors.primary,
          ),
          SizedBox(height: 14),
          GoalCard(
            icon: Icons.laptop_mac_rounded,
            title: 'Novo notebook',
            saved: 'R\$ 3.200',
            target: 'R\$ 5.500',
            progress: 0.58,
            color: AppColors.warning,
          ),
          SizedBox(height: 14),
          GoalCard(
            icon: Icons.shield_rounded,
            title: 'Reserva de emergencia',
            saved: 'R\$ 14.600',
            target: 'R\$ 18.000',
            progress: 0.81,
            color: AppColors.success,
          ),
        ],
      ),
    );
  }
}

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Cartoes',
      subtitle: 'Faturas e limites',
      child: Column(
        children: const [
          CreditCardMock(),
          SizedBox(height: 18),
          MetricTile(
            icon: Icons.payments_rounded,
            label: 'Fatura atual',
            value: 'R\$ 2.438,20',
            color: AppColors.warning,
          ),
          SizedBox(height: 12),
          MetricTile(
            icon: Icons.credit_score_rounded,
            label: 'Limite disponivel',
            value: 'R\$ 7.561,80',
            color: AppColors.success,
          ),
          SizedBox(height: 20),
          SectionTitle(title: 'Parcelamentos'),
          SizedBox(height: 10),
          PaymentRow(label: 'Celular', value: '4/10', amount: 'R\$ 189,90'),
          PaymentRow(label: 'Curso', value: '2/6', amount: 'R\$ 320,00'),
          PaymentRow(label: 'Moveis', value: '8/12', amount: 'R\$ 410,00'),
        ],
      ),
    );
  }
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Relatorios',
      subtitle: 'Analise dos seus gastos',
      bottomBarIndex: 2,
      child: Column(
        children: const [
          ReportChart(),
          SizedBox(height: 18),
          SectionTitle(title: 'Categorias'),
          SizedBox(height: 12),
          CategorySpend(
            label: 'Moradia',
            value: '35%',
            color: AppColors.primary,
          ),
          CategorySpend(
            label: 'Alimentacao',
            value: '24%',
            color: AppColors.success,
          ),
          CategorySpend(
            label: 'Transporte',
            value: '18%',
            color: AppColors.warning,
          ),
          CategorySpend(label: 'Lazer', value: '12%', color: AppColors.danger),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Perfil',
      subtitle: 'Conta e preferencias',
      bottomBarIndex: 3,
      child: Column(
        children: const [
          ProfileHeader(),
          SizedBox(height: 20),
          SettingsRow(icon: Icons.lock_outline_rounded, label: 'Seguranca'),
          SettingsRow(
            icon: Icons.account_balance_rounded,
            label: 'Contas conectadas',
          ),
          SettingsRow(
            icon: Icons.notifications_none_rounded,
            label: 'Notificacoes',
          ),
          SettingsRow(icon: Icons.palette_outlined, label: 'Aparencia'),
          SettingsRow(icon: Icons.help_outline_rounded, label: 'Ajuda'),
          SizedBox(height: 18),
          SecondaryButton(label: 'Sair da conta', icon: Icons.logout_rounded),
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
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.26),
            blurRadius: 24,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saldo total',
            style: TextStyle(color: AppColors.canvas, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'R\$ 24.860,00',
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
                style: TextStyle(
                  color: AppColors.primaryDark,
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

class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.line),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w800,
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

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      (Icons.add_rounded, 'Adicionar'),
      (Icons.swap_horiz_rounded, 'Transferir'),
      (Icons.analytics_rounded, 'Analise'),
      (Icons.savings_rounded, 'Meta'),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final action in actions)
          Column(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.brandName,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.line),
                ),
                child: Icon(action.$1, color: Colors.white),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 72,
                child: Text(
                  action.$2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
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
              color: AppColors.muted,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (obscure)
                const Icon(
                  Icons.visibility_off_outlined,
                  color: AppColors.muted,
                  size: 18,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.ink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          side: const BorderSide(color: AppColors.line),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        icon: Icon(icon ?? Icons.arrow_forward_rounded),
        label: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class CircleIcon extends StatelessWidget {
  const CircleIcon({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.line),
      ),
      child: Icon(icon, color: AppColors.ink),
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
            style: const TextStyle(
              color: AppColors.ink,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const Text(
          'Ver tudo',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class SearchBarMock extends StatelessWidget {
  const SearchBarMock({super.key});

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
          Icon(Icons.search_rounded, color: AppColors.muted),
          SizedBox(width: 10),
          Text(
            'Buscar transacao',
            style: TextStyle(
              color: AppColors.muted,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class SegmentedMock extends StatelessWidget {
  const SegmentedMock({super.key, required this.labels});

  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
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
                  boxShadow: i == 0
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  labels[i],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: i == 0 ? AppColors.ink : Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
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
              color: transaction.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(transaction.icon, color: transaction.color),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  transaction.category,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                ),
              ],
            ),
          ),
          Text(
            transaction.amount,
            style: TextStyle(
              color: transaction.income ? AppColors.success : AppColors.ink,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      (Icons.restaurant_rounded, 'Comida'),
      (Icons.directions_bus_rounded, 'Transporte'),
      (Icons.home_rounded, 'Casa'),
      (Icons.movie_rounded, 'Lazer'),
    ];

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 2.65,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        for (final category in categories)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.line),
            ),
            child: Row(
              children: [
                Icon(category.$1, color: AppColors.primary, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    category.$2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: const Row(
        children: [
          SizedBox(
            width: 84,
            height: 84,
            child: CircularProgressIndicator(
              value: 0.64,
              strokeWidth: 10,
              backgroundColor: AppColors.canvas,
              color: AppColors.primaryDark,
            ),
          ),
          SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '64% usado',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'R\$ 3.190 de R\$ 5.000 planejados para maio.',
                  style: TextStyle(color: AppColors.muted, height: 1.35),
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
    required this.color,
  });

  final String title;
  final String subtitle;
  final double value;
  final Color color;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                '${(value * 100).round()}%',
                style: TextStyle(color: color, fontWeight: FontWeight.w900),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: AppColors.muted)),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 9,
              color: color,
              backgroundColor: color.withValues(alpha: 0.12),
            ),
          ),
        ],
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  const GoalCard({
    super.key,
    required this.icon,
    required this.title,
    required this.saved,
    required this.target,
    required this.progress,
    required this.color,
  });

  final IconData icon;
  final String title;
  final String saved;
  final String target;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.ink,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(saved, style: const TextStyle(fontWeight: FontWeight.w900)),
              const Text(' / ', style: TextStyle(color: AppColors.muted)),
              Text(target, style: const TextStyle(color: AppColors.muted)),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              color: color,
              backgroundColor: color.withValues(alpha: 0.12),
            ),
          ),
        ],
      ),
    );
  }
}

class CreditCardMock extends StatelessWidget {
  const CreditCardMock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'FinControl Black',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                ),
              ),
              Spacer(),
              Icon(Icons.contactless_rounded, color: Colors.white),
            ],
          ),
          Spacer(),
          Text(
            '••••  ••••  ••••  4821',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.4,
            ),
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Text('ANA MARTINS', style: TextStyle(color: Color(0xFFD1D5DB))),
              Spacer(),
              Text('05/30', style: TextStyle(color: Color(0xFFD1D5DB))),
            ],
          ),
        ],
      ),
    );
  }
}

class PaymentRow extends StatelessWidget {
  const PaymentRow({
    super.key,
    required this.label,
    required this.value,
    required this.amount,
  });

  final String label;
  final String value;
  final String amount;

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
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Text(value, style: const TextStyle(color: AppColors.muted)),
          const SizedBox(width: 16),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.w900)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Gastos na semana',
            style: TextStyle(
              color: AppColors.ink,
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
                                      ? AppColors.primaryDark
                                      : AppColors.canvas,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          labels[i],
                          style: const TextStyle(color: AppColors.muted),
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
  const CategorySpend({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.muted,
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
              color: AppColors.canvas,
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.primary,
              size: 34,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ana Martins',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text('ana@email.com', style: TextStyle(color: AppColors.muted)),
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
          Icon(icon, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.ink,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.muted),
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
    required this.color,
    this.income = false,
  });

  final String title;
  final String category;
  final String amount;
  final IconData icon;
  final Color color;
  final bool income;
}

class BudgetData {
  const BudgetData({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.color,
  });

  final String title;
  final String subtitle;
  final double value;
  final Color color;
}

const sampleTransactions = [
  TransactionData(
    title: 'Salario',
    category: 'Receita',
    amount: '+R\$ 8.240',
    icon: Icons.work_rounded,
    color: AppColors.success,
    income: true,
  ),
  TransactionData(
    title: 'Mercado Bom Preco',
    category: 'Alimentacao',
    amount: '-R\$ 248,90',
    icon: Icons.shopping_cart_rounded,
    color: AppColors.warning,
  ),
  TransactionData(
    title: 'Apartamento',
    category: 'Moradia',
    amount: '-R\$ 1.680',
    icon: Icons.home_rounded,
    color: AppColors.primary,
  ),
  TransactionData(
    title: 'Uber',
    category: 'Transporte',
    amount: '-R\$ 42,70',
    icon: Icons.local_taxi_rounded,
    color: AppColors.danger,
  ),
  TransactionData(
    title: 'Freelance',
    category: 'Receita extra',
    amount: '+R\$ 1.200',
    icon: Icons.laptop_mac_rounded,
    color: AppColors.success,
    income: true,
  ),
  TransactionData(
    title: 'Cinema',
    category: 'Lazer',
    amount: '-R\$ 78,00',
    icon: Icons.movie_rounded,
    color: AppColors.primary,
  ),
];

const sampleBudgets = [
  BudgetData(
    title: 'Moradia',
    subtitle: 'R\$ 1.680 de R\$ 1.900',
    value: 0.88,
    color: AppColors.primary,
  ),
  BudgetData(
    title: 'Alimentacao',
    subtitle: 'R\$ 740 de R\$ 1.100',
    value: 0.67,
    color: AppColors.success,
  ),
  BudgetData(
    title: 'Transporte',
    subtitle: 'R\$ 290 de R\$ 500',
    value: 0.58,
    color: AppColors.warning,
  ),
  BudgetData(
    title: 'Lazer',
    subtitle: 'R\$ 480 de R\$ 600',
    value: 0.80,
    color: AppColors.danger,
  ),
];
