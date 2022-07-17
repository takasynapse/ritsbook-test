import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';



class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Landing Page'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image:DecorationImage(
            image: AssetImage('assets/images/landing_page.png'),
            fit : BoxFit.cover,
            )
        )
      ),
      );
  }
}