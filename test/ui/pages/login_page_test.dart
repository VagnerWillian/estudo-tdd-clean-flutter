
import 'package:estudo_clean_tdd_flutter/ui/pages/pages.exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  Future loadPage(WidgetTester tester)async{
    final loginPage = MaterialApp(home:LoginPage());
    await tester.pumpWidget(loginPage);
  }

  testWidgets('Should load with correct initial state', (WidgetTester tester) async{
    await loadPage(tester);
    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(emailTextChildren, findsOneWidget);

    final passTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(passTextChildren, findsOneWidget);

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);
  });

  testWidgets('Should call validate with correct values', (WidgetTester tester) async{
    await loadPage(tester);

  });
}