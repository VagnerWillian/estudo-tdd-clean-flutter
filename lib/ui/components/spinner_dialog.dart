import 'package:flutter/material.dart';

void showLoading (BuildContext context)=> showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_)=>SimpleDialog(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text("Aguarde...", textAlign: TextAlign.center)
          ],
        )
      ],
    )
);

void hideLoading(context){
  Navigator.pop(context);
}