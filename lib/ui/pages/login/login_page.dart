import 'package:flutter/material.dart';

import '../../components/components.exports.dart';
import '../pages.exports.dart';

class LoginPage extends StatefulWidget {

  final LoginPresenter? presenter;
  LoginPage(this.presenter);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  void dispose() {
    super.dispose();
    widget.presenter!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          widget.presenter!.visibleLoadingStream.listen((isLoading) {
            if(isLoading){
              showLoading(context);
            }else{
              hideLoading(context);
            }
          });

          widget.presenter!.mainErrorStream.listen((error) {
            if(error!=null){
              showErrorMessage(context, error);
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
                          stream: widget.presenter!.emailErrorStream,
                          builder: (_, snapshot)=> TextFormField(
                            onChanged: widget.presenter!.validateEmail,
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
                            stream: widget.presenter!.passwordErrorStream,
                            builder: (_, snapshot) {
                              return TextFormField(
                                onChanged: widget.presenter!.validatePassword,
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
                            stream: widget.presenter!.enableButtonStream,
                            builder: (_, snapshot) {
                              return RaisedButton(
                                onPressed: snapshot.hasData && snapshot.data == true ? widget.presenter!.auth : null,
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