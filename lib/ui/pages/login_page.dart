import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image(image: AssetImage('assets/logo.png')),
            ),
            Text("LOGIN"),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      icon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  ElevatedButton(onPressed: (){}, child: Text('ENTRAR'),),
                  TextButton.icon(
                      icon: Icon(Icons.person),
                      onPressed: (){},
                      label: Text("Criar conta"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
