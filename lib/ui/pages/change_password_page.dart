import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_cc/domain/blocs/user/user_bloc.dart';
import 'package:flutter_firebase_cc/domain/globals.dart';

class ChangePasswordPage extends StatelessWidget {
  final Function onAccept;

  const ChangePasswordPage({this.onAccept});

  @override
  Widget build(BuildContext context) {
    final _oldPasswordController = TextEditingController();
    final _newPasswordController = TextEditingController();
    final _newRepeatPasswordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text('Change password')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(labelText: 'Old password'),
                controller: _oldPasswordController,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(labelText: 'New password'),
                controller: _newPasswordController,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(labelText: 'Re-enter password'),
                controller: _newRepeatPasswordController,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () {
                    if (_newRepeatPasswordController.text ==
                        _newPasswordController.text) {
                      BlocProvider.of<UserBloc>(context).add(
                          UserChangePasswordEvent(_newPasswordController.text,
                              _oldPasswordController.text));
                      password = _newPasswordController.text;
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Accept'),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
