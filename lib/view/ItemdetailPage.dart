import "package:cloud_firestore/cloud_firestore.dart";
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:projectritsbook_native/view/Chat.dart';
import 'package:projectritsbook_native/view/SignUpPage.dart';
import 'package:projectritsbook_native/view/Trade.dart';
import 'package:projectritsbook_native/view/EditItem.dart';
            // ignore: prefer_const_literals_to_create_immutables
class ItemdetailPage extends StatefulWidget {
  final DocumentSnapshot document;
  ItemdetailPage(this.document);
  @override
  _ItemdetailPageState createState() => _ItemdetailPageState();
}


class _ItemdetailPageState extends State<ItemdetailPage> {
final String? uid = FirebaseAuth.instance.currentUser?.uid;
Future<void> Purchase(itemID) async {
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('purchase')
          .doc()
          .set({
        'itemID': itemID,
      });
      FirebaseFirestore.instance.collection('textbooks').doc(itemID).update({
        'isSold': false,
      });
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.document["userID"])
          .collection('information')
          .doc(widget.document.id)
          .set({
            'information': "出品中の商品「”${widget.document["item"]}”」が購入されました。",
            'isRead': false,
            'timestamp': DateTime.now(),
          })
          .then((value) => print("success"))
          .catchError((error) => print(error));
    }
  });
}
  Future<void> _showDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('購入しますか？'),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('購入'),
              onPressed: () {
                Purchase(widget.document.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TradeChatPage(widget.document),
                )
                );
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _showDialogCheckauth() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ログインしてください'),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('ログインする'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width:71,
        height: 71,
        child:
         FloatingActionButton(
          onPressed: () {
            if (widget.document['isSold'] ==true)
            if (uid == null) {
              _showDialogCheckauth();
            } else {
              _showDialog();
            }
            else
            {
              print('aa');
            }
          },
          child:Text("購入する",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,fontFamily: "Inter"),),
          backgroundColor: Colors.red,
          // child: const Icon(Icons.shopping_cart),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(widget.document["item"],
        
        style: 
        TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: "Inter",
          color: Colors.black,
        ),
        ),
        backgroundColor: Colors.white,

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(widget.document["img_url"]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.document["item"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('￥'+widget.document["price"].toString(),style: 
                TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.document["description"],
                style: TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Opacity(opacity: 0.5,child: Text('商品の状態')),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.document["condition"]),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(widget.document["seller"] + "さんの出品"!=null?widget.document["seller"] + "さんの出品":""),
              // ),
              SizedBox(
                      height: 20,
                    ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton.icon(
                        style:ElevatedButton.styleFrom(
                          side:const BorderSide(
                            width: 2.0,
                            color: Color(0xff727272)),
                          primary: Colors.white,
                          onPrimary: Color(0xff727272),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(widget.document)),
                          );
                        },
                        icon: Icon(Icons.message),
                        label: Text("コメントする"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                if (uid == widget.document['userID'])
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                            width: 2.0,
                            color: Color(0xff727272)),
                        primary: Colors.white,
                        onPrimary: Color(0xff727272),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditItem(widget.document)),
                        );
                      },
                      child: const Text("編集する"),
                    ),
                  )
                else if (widget.document["isSold"] == true)
                  Container(
                    width: 200,
                    height: 50,
                    child: ElevatedButton.icon(
                      style :ElevatedButton.styleFrom(
                        side: BorderSide(
                          width: 2.0, 
                          color: Color(0xfff13838)),
                        primary: Colors.white,
                        onPrimary: Color(0xfff13838),
                      ),
                      onPressed: () {
                        FirebaseAuth.instance.authStateChanges().listen((user) {
                          if (user != null) {
                            if (widget.document["isSold"] == true) {
                              _showDialog();
                            } else {
                              null;
                            }
                          } else {
                            _showDialogCheckauth();
                          }
                        });
                      },
                      icon:const Icon(Icons.shopping_cart),
                      label:const Text("購入する"),
                    ),
                  )
                else
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(onPressed: null, child: Text("売り切れ"))),
                if(uid !=null && uid == widget.document['userID'] &&widget.document["isSold"] == false)
                ElevatedButton(
                      style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 74, 176, 106)),
                      primary: Colors.white,
                      onPrimary: Color.fromARGB(255, 74, 176, 106),
                    ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TradeChatPage(widget.document)),
                    );
                  },
                  child: const Text("取引画面へ"),
                )
                else if (FirebaseFirestore.instance.
                collection('users').doc(uid).collection('purchase').doc(widget.document.id).get() == widget.document['userID']
                && widget.document["isSold"] == false)
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                          width: 2.0,
                          color: Color.fromARGB(255, 141, 83, 83)),
                      primary: Colors.white,
                      onPrimary: Color.fromARGB(255, 141, 83, 83),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TradeChatPage(widget.document)),
                      );
                    },
                    child: const Text("取引画面へ"),
                  ),
                ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
