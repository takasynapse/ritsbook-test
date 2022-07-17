import 'package:flutter/material.dart';


class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        'assets/images/ritsbook_logo2.svg',
        height: 100,
        width: 100,
      ),
    );
  }
}