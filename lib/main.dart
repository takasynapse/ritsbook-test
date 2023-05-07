import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectritsbook_native/presentation/view/LandingPage/landingafterlogin.dart';
import 'package:projectritsbook_native/presentation/view/exhibition.dart';
import 'package:projectritsbook_native/presentation/view/profile.dart';
import 'package:projectritsbook_native/presentation/view/notification.dart';
import 'package:projectritsbook_native/presentation/view/tradingitem.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: Ritsbook()));
}

class Ritsbook extends StatefulWidget {
  const Ritsbook({Key? key}) : super(key: key);
  @override
  _RitsbookState createState() => _RitsbookState();
}

final userIdProvider = StreamProvider.autoDispose((ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user?.uid);
});

class _RitsbookState extends State<Ritsbook> {
  var _navIndex = 0;
  static final _screens = [
    LandingPage(),
    NotificationPage(),
    Exhibition(),
    TradingItem(),
    Profile()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _navIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _screens[_navIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _navIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'ホーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'お知らせ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined),
              label: '出品',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows_outlined),
              label: '取引',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'マイページ',
            ),
          ],
        ),
      ),
    );
  }
}
