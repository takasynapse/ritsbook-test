import 'package:flutter/material.dart';
import 'package:projectritsbook_native/presentation/pages/LoginPage.dart';

Future<void> checkLoginDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          MaterialPageRoute(builder: (context) => const LoginPage());
          return true;
        },
        child: AlertDialog(
          title: const Text('ログインしてください'),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
                child: const Text('ログイン'),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }),
          ],
        ),
      );
    },
  );
}
