import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:estudo_clean_tdd_flutter/ui/pages/pages.exports.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter{}

void main(){

  late final LoginPresenter presenter;

  Future loadPage(WidgetTester tester)async{
    presenter = LoginPresenterSpy();
    final loginPage = MaterialApp(home: LoginPage(presenter));
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

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(()=>presenter.validateEmail(email));

    final pass = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), pass);
    verify(()=>presenter.validatePassword(pass));
  });
}