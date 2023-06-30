import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectritsbook_native/presentation/pages/landingPage/landing_page.dart';
import 'package:projectritsbook_native/presentation/pages/exhibition/exhibition_page.dart';
import 'package:projectritsbook_native/presentation/pages/my_page/my_page.dart';
import 'package:projectritsbook_native/presentation/pages/notification.dart';
import 'package:projectritsbook_native/presentation/pages/tradingitem.dart';
import 'package:projectritsbook_native/firebase_options.dart';
import 'package:projectritsbook_native/color_schemes.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: RitsBook()));
}

class RitsBook extends StatefulWidget {
  const RitsBook({Key? key}) : super(key: key);
  @override
  RitsBookState createState() => RitsBookState();
}

class RitsBookState extends State<RitsBook> {
  var _navIndex = 0;
  static final _screens = [
    const LandingPage(),
    NotificationPage(),
    const ExhibitionPage(),
    TradingItem(),
    MyPage()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _navIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      debugShowCheckedModeBanner: false,
      
      home: Scaffold(
        body: _screens[_navIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _navIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
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
