import 'package:estudo_clean_tdd_flutter/ui/pages/login/components/components.exports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  child: Provider(
                    create: (_)=>widget.presenter,
                    child: Form(
                      child: Column(
                        children: [
                          EmailInput(),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 32),
                            child: PassInput(),
                          ),
                          const LoginButton(),
                          FlatButton.icon(
                              icon: const Icon(Icons.person),
                              onPressed: (){},
                              label: const Text("Criar conta"))
                        ],
                      ),
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