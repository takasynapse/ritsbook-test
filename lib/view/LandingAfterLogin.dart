import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:projectritsbook_native/view/ItemdetailPage.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class LandingPageAfter extends StatefulWidget {
  @override
  _LandingPageAfterState createState() => _LandingPageAfterState();
}

class _LandingPageAfterState extends State<LandingPageAfter> {
  var documentList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.white,
        ),
      ),
      body: Consumer(builder: (context, model, child) {
        return Row(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("textbooks")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 80,
                        left: 20,
                        right: 20, 
                        ),
                    child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 4,
                        childAspectRatio: 0.65,
                      ),
                      itemBuilder: (context, index) {
                        final document = snapshot.data!.docs[index];
                        decoration:
                        BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        );
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemdetailPage(
                                  document,
                                ),
                              ),
                            );
                          },
                          child: Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (document["isSold"] == true)
                                    Stack(
                                      children: [
                                        Ink.image(
                                          image: document['img_url'] != null
                                              ? NetworkImage(
                                                  document['img_url'])
                                              : AssetImage(
                                                      'assets/images/placeholder.png')
                                                  as ImageProvider,
                                          height: 116,
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 90),
                                          child: Align(
                                            widthFactor: 0.5,
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              '¥' +
                                                  document['price']
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontFamily: "Inter",
                                                fontWeight: FontWeight.w700,
                                                backgroundColor:
                                                    Color.fromARGB(255, 107,
                                                            103, 103)
                                                        .withOpacity(0.3),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  else if (document["isSold"] == false)
                                    Stack(children: [
                                      Ink.image(
                                        image: document['img_url'] != null
                                            ? NetworkImage(
                                                document['img_url'])
                                            : AssetImage(
                                                    'assets/images/placeholder.png')
                                                as ImageProvider,
                                        height: 112,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        height: 112,
                                        width: 138,
                                        color: Colors.black.withOpacity(0.5),
                                        child: Center(
                                          child: Text(
                                            "SOLD",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                            const EdgeInsets.only(top: 90),
                                        child: Align(
                                          widthFactor: 0.5,
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            '￥' +
                                                document['price'].toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontFamily: "Inter",
                                              fontWeight: FontWeight.w700,
                                              backgroundColor: Color.fromARGB(
                                                      255, 107, 103, 103)
                                                  .withOpacity(0.3),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        document['item'] != null
                                            ? document['item']
                                            : 'No title',
                                        // 文字が長い場合の折り返し
                                        // overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
