import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectritsbook_native/presentation/pages/LandingPage/landingpage.dart';
import 'package:projectritsbook_native/presentation/pages/exhibition/exhibition.dart';
import 'package:projectritsbook_native/presentation/pages/profile.dart';
import 'package:projectritsbook_native/presentation/pages/notification.dart';
import 'package:projectritsbook_native/presentation/pages/tradingitem.dart';
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

class _RitsbookState extends State<Ritsbook> {
  var _navIndex = 0;
  static final _screens = [
    const LandingPage(),
    NotificationPage(),
    const ExhibitionPage(),
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
