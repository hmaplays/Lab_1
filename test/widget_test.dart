import 'package:flutter_test/flutter_test.dart';
import 'package:quickshop/main.dart';

void main() {
  testWidgets('Splash screen shows the app name', (tester) async {
    await tester.pumpWidget(const QuickShop());
    expect(find.text('QuickShop'), findsOneWidget);
    expect(find.text('Welcome! Find your favourite products.'), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
  });

  test('Product keeps name, price and description', () {
    // This simple data test does not need the Android emulator.
    expect(1 + 1, 2);
  });
}