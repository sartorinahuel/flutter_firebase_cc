import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_firebase_cc/domain/blocs/user/user_bloc.dart';

class ConfirmDeletePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _oldPasswordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Confirm delete')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(labelText: 'Enter password to confirm'),
                controller: _oldPasswordController,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context)
                        .add(UserDeleteUserEvent(_oldPasswordController.text));
                    Navigator.of(context).pop();
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
