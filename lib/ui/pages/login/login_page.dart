import 'package:flutter/material.dart';

import '../../components/components.exports.dart';
import '../pages.exports.dart';

class LoginPage extends StatelessWidget {

  final LoginPresenter? presenter;
  LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter!.visibleLoadingStream.listen((isLoading) {
            if(isLoading){
              showDialog(
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
            }else{
              Navigator.pop(context);
            }
          });
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LoginHeader(),
                Center(child: Headline1(text: "Login")),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    child: Column(
                      children: [
                        StreamBuilder<String?>(
                          stream: presenter!.emailErrorStream,
                          builder: (_, snapshot)=> TextFormField(
                            onChanged: presenter!.validateEmail,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight),
                              errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 32),
                          child: StreamBuilder<String?>(
                            stream: presenter!.passwordErrorStream,
                            builder: (_, snapshot) {
                              return TextFormField(
                                onChanged: presenter!.validatePassword,
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                                  errorText: snapshot.data?.isEmpty==true ? null : snapshot.data
                                ),
                                obscureText: true,
                              );
                            }
                          ),
                        ),
                        StreamBuilder<bool>(
                            stream: presenter!.enableButtonStream,
                            builder: (_, snapshot) {
                              return RaisedButton(
                                onPressed: snapshot.hasData && snapshot.data == true ? presenter!.auth : null,
                                child: const Text('ENTRAR'),);
                            }
                        ),
                        FlatButton.icon(
                            icon: const Icon(Icons.person),
                            onPressed: (){},
                            label: const Text("Criar conta"))
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}