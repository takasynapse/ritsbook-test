//購入した商品一覧のページ
import 'package:flutter/material.dart';
import 'package:projectritsbook_native/view/PurchasedList.dart';
import 'package:projectritsbook_native/view/SellingList.dart';

class TradingItem extends StatefulWidget {
  @override
  _TradingItemState createState() => _TradingItemState();
}


class _TradingItemState extends State<TradingItem> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 196, 183, 183),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(
                  text: '出品した商品',
                ),
                Tab(
                  text: '購入した商品',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              SellingList(),
              PurchasedList(),
            ],
          ),
        ),
      ),
    );
  }

}
