import 'package:flutter/material.dart';

class Headline1 extends StatelessWidget {
  final String text;

  Headline1({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text("LOGIN",
      style: Theme.of(context).textTheme.headline1,
    );
  }
}
