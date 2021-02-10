import "package:flutter/material.dart";

showDialogWithMessage(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(title: new Text(message), actions: [
            FlatButton(
              child: Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]));
}
