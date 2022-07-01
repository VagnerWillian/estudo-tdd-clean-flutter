import 'package:estudo_clean_tdd_flutter/ui/pages/pages.exports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PassInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter?>(context);
    return StreamBuilder<String?>(
        stream: presenter!.passwordErrorStream,
        builder: (_, snapshot) {
          return TextFormField(
            onChanged: presenter.validatePassword,
            decoration: InputDecoration(
                labelText: 'Senha',
                icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight),
                errorText: snapshot.data?.isEmpty==true ? null : snapshot.data
            ),
            obscureText: true,
          );
        }
    );
  }
}
