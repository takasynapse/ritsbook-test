
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
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(  
        preferredSize: Size.fromHeight(0),
        child: AppBar(
        backgroundColor: Colors.white,
        ),
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
                                  if (document["isSold"] == true)
                                  Ink.image(image: document['img_url'] != null ? NetworkImage(document['img_url']) : AssetImage('assets/images/placeholder.png') as ImageProvider,
                                    height: 112,
                                    fit: BoxFit.cover,
                                  )
                                  else if (document["isSold"] == false)
                                  Stack(
                                    children:[
                                  Ink.image(image: document['img_url'] != null ? NetworkImage(document['img_url']) : AssetImage('assets/images/placeholder.png') as ImageProvider,
                                    height: 112,
                                    fit: BoxFit.cover,
                                  ),
                                  Container(
                                    height: 112,
                                    width: 138,
                                    color:Colors.black.withOpacity(0.5),
                                    child: Center(
                                      child: Text("SOLD",style: TextStyle(color:Colors.white,fontSize: 20),
                                      
                                      ),
                                    ),
                                    
                                  ),
                                    ]
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
  }

