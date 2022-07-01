import 'package:estudo_clean_tdd_flutter/ui/pages/pages.exports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter?>(context);
    return StreamBuilder<bool>(
        stream: presenter!.enableButtonStream,
        builder: (_, snapshot) {
          return RaisedButton(
            onPressed: snapshot.hasData && snapshot.data == true ? presenter.auth : null,
            child: const Text('ENTRAR'),);
        }
    );
  }
}
