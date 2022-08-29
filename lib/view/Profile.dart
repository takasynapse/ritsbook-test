import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String user = 'aaaaa';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('マイページ'),
      ),
      body: Center(
        child:Center(
          child:Padding(
            padding:const EdgeInsets.all(10.0),
            child:ListView(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('さんのマイページ'),         
                Text('ユーザー名'),
                Text('学部学科'),
                Text('学年'),
                TextButton.icon(
                  onPressed: (){
                    print('aa');
                  },
                  icon:Icon(Icons.edit),
                  label:Text('プロフィール編集'),
                ),
                TextButton.icon(
                  onPressed: (){
                    print('aa');
                  },
                  icon:Icon(Icons.notifications),
                  label:Text('お知らせ'),
                ),
                TextButton.icon(
                  onPressed: (){
                    print('aa');
                  },
                  icon:Icon(Icons.camera_alt_outlined),
                  label:Text('出品した商品'),
                ),
                TextButton.icon(
                  onPressed: (){
                    print('aa');
                  },
                  icon:Icon(Icons.shopping_bag),
                  label:Text('購入した商品'),
                ),
                TextButton.icon(
                  onPressed: (){
                    print('aa');
                  },
                  icon:Icon(Icons.favorite),
                  label:Text('いいね（未実装）'),
                ),
                ],
            )
          )
        ) ,
        
      ),
    );
  }
}