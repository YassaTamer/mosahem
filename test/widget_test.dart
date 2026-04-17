import 'package:flutter_test/flutter_test.dart';
import 'package:mosahem/core/network/dio_helper.dart';
import 'package:mosahem/main.dart';

void main() {
  testWidgets('App loads', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp(dio: DioHelper.instance.client));

    expect(find.byType(MyApp), findsOneWidget);
  });
}
