import 'package:flutter/material.dart';
import 'package:projectritsbook_native/presentation/pages/landing_page/landing_page.dart';

Future<void> successSignUpDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: const Text('登録完了'),
          content: const Text('登録が完了しました。'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context,
                  MaterialPageRoute(builder: (context) => const LandingPage())),
            ),
          ],
        ),
      );
    },
  );
}
