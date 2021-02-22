import 'package:flutter/material.dart';
import 'package:socialapp/contant.dart';
import 'package:socialapp/screens/login_screen.dart';

class AccountCreatedAlert extends StatelessWidget {
  final BuildContext context;
  AccountCreatedAlert({Key key, this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      title: Text("You\'re account created successfully."),
      actions: [
        FlatButton(
            minWidth: 150,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: kPrimaryColor,
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                ),
            child: Text(
              'Login',
              style: kButtonTextStyle,
            ))
      ],
    );
  }
}

class UsernameAlreadyTakenAlert extends StatelessWidget {
  final BuildContext context;
  const UsernameAlreadyTakenAlert({
    Key key,
    this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(0),
      title: Text("Username already taken!"),
      actions: [
        FlatButton(
          minWidth: 150,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: kPrimaryColor,
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Try again',
            style: kButtonTextStyle,
          ),
        )
      ],
    );
  }
}
