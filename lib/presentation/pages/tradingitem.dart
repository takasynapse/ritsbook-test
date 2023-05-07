//購入した商品一覧のページ
import 'package:flutter/material.dart';
import 'package:projectritsbook_native/presentation/pages/PurchasedList.dart';
import 'package:projectritsbook_native/presentation/pages/sellinglist.dart';

class TradingItem extends StatefulWidget {
  @override
  _TradingItemState createState() => _TradingItemState();
}

class _TradingItemState extends State<TradingItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Center(
                child: Text(
              "商品一覧 ",
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Inter",
                fontWeight: FontWeight.w700,
              ),
            )),
            bottom: const TabBar(
              labelColor: Colors.black,
              // labelStyle: TextStyle(fontSize: 20),
              indicatorColor: Color(0xffff6b6b),
              tabs: <Widget>[
                Tab(
                  text: '購入した商品',
                ),
                Tab(
                  text: '出品した商品',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              PurchasedList(),
              SellingList(),
            ],
          ),
        ),
      ),
    );
  }
}
