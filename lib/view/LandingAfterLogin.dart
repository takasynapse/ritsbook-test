
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
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
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Ritsbook',
        style: TextStyle(color: Colors.black),),
        
        // backgroundColor: Colors.white,
      ),
      body: Consumer(builder: (context, model ,child){
        return Row(
          children: [
            Expanded(
              child:StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("textbooks").snapshots(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:const  SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index){
                        final document = snapshot.data!.docs[index];
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(5),
                          // boxShadow: [
                          //   BoxShadow(
                          //     blurRadius: 4.0,
                          //     offset: const Offset(0, 4),
                          //   ),
                          // ],
                        );
                        
                        return SizedBox(
                          height: 145,
                          width: 138,
                          child: GestureDetector(
                            onTap: (){
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
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              
                              // shadowColor: Color(0x3f000000),
                              child:Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height:10),
                                  Ink.image(image: document['img_url'] != null ? NetworkImage(document['img_url']) : AssetImage('assets/images/placeholder.png') as ImageProvider,
                                    height: 112,
                                    fit: BoxFit.cover,
                                  ),
                                  // Text('￥'+document['price'].toString(),
                                  // style:TextStyle(
                                  //   color: Colors.black,
                                  //   fontSize: 10,
                                  //   fontFamily: "Inter",
                                  //   fontWeight: FontWeight.w700,
                                  //   backgroundColor: Colors.black.withOpacity(0.1),
                                  // ),
                                  // ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      document['item'] != null ? document['item'] : 'No title',
                                      // 文字が長い場合の折り返し
                                      // overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style:const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  
                                  // ListTile(
                                  //   title: Text(document['item']),
                                  //   // subtitle: Text(document['author']),
                                  //   onTap: (){
                                  //     Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //         builder: (context) => ItemdetailPage(document),
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                ],
                              ) 
                            ),
                          ),
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
    // return MaterialApp(
    //   home: ChangeNotifierProvider<MainModel>(
    //     create:(_) => MainModel()..fetchBooks(),
    //     child:Scaffold(
    //     appBar:AppBar(
    //       title:Text("ランディングページ"),
    //     ),
    //     body:Consumer<MainModel>(
    //       builder:(context,model,child){
    //         final documentList = model.documentList;
    //         return ListView.builder(
    //           itemCount: documentList.length,
    //           itemBuilder: (BuildContext context,int item){
    //             return ListTile(
    //               title: Text(documentList[item]["item"]),
    //               leading: Image.network(documentList[item]["img_url"]),
    //               subtitle: Text(documentList[item]["price"].toString()),
    //               trailing: documentList[item]["isSold"] == true ? Text("販売中") : Text("売り切れ "),
    //               onTap:() {
    //                 // print(documentList[item].id);
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => ItemdetailPage(documentList[item]),
    //                   ),
    //                 );},
    //             );
    //           }
    //         );
    //       }
    //     )
    //     )
    //     )
    //     );
  }

