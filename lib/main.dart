import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectritsbook_native/view/LandingAfterLogin.dart';
import 'package:projectritsbook_native/view/Exhibition.dart';
import 'package:projectritsbook_native/view/Profile.dart';
import 'package:projectritsbook_native/view/Notifications.dart';
import 'package:projectritsbook_native/view/TradingItem.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  // debugPaintSizeEnabled=true;
  runApp(const ProviderScope(child: Ritsbook()));
}
class Ritsbook extends StatefulWidget{
  const Ritsbook({Key? key}) : super(key: key);
  @override
  _RitsbookState createState() => _RitsbookState();
}

final userIdProvider = StreamProvider.autoDispose((ref) {
  return FirebaseAuth.instance.authStateChanges().map((user) => user?.uid);
} );

class _RitsbookState extends State<Ritsbook>{
  var _navIndex = 0;
  static final _screens = [LandingPageAfter(),NotificationPage(),Exhibition(),TradingItem(),Profile()];
  void _onItemTapped(int index){
    setState(() {
      _navIndex = index;
    });
  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: _screens[_navIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:_navIndex,
          onTap: _onItemTapped,
          items:const <BottomNavigationBarItem> [
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