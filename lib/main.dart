import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:projectritsbook_native/view/LandingAfterLogin.dart';
import 'package:projectritsbook_native/view/LandingPage.dart';
import 'package:projectritsbook_native/view/Exhibitation.dart';
import 'firebase_options.dart';
// final constProvider =StateProvider((ref)=>0);
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(const MyApp(const ProviderScope(child:MyApp())));
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home:MyApp(),
      )
      );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget>createState(){
    return _State();
  }
}

class _State extends State<MyApp>{
  var _navIndex = 0;
  var _label = '';
  var _titles = [LandingPage(),LandingPageAfter(),Exhibition()];

  void _onItemTapped(int index){
    setState(() {
      _navIndex = index;
    });
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Ritsbook'),
      // ),
      body: _titles[_navIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:_navIndex,
        onTap: _onItemTapped,
        items:const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Exhibition',
          ),
        ],
    type: BottomNavigationBarType.fixed,
      ),
    );
  }
}