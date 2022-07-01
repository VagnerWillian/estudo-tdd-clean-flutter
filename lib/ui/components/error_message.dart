import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String error){
  SnackBar snack = SnackBar(
      content: Text(error, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.red.shade900
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}