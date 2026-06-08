import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders welcome and navigates to login', (tester) async {
    await tester.pumpWidget(const FinControlApp() as Widget);

    expect(find.text('FinControl'), findsWidgets);
    expect(find.text('Controle suas financas com clareza'), findsOneWidget);

    await tester.tap(find.text('Ja tenho uma conta'));
    await tester.pumpAndSettle();

    expect(find.text('Entrar'), findsOneWidget);
    expect(find.text('Google'), findsNothing);
  });

  testWidgets('login opens dashboard', (tester) async {
    await tester.pumpWidget(const FinControlApp() as Widget);

    await tester.tap(find.text('Ja tenho uma conta'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Acessar conta'));
    await tester.pumpAndSettle();

    expect(find.text('Ola, Francisco'), findsOneWidget);
    expect(find.text('Saldo total'), findsOneWidget);
  });
}

class FinControlApp {
  const FinControlApp();
}
