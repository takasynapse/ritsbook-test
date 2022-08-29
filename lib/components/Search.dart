// import 'package:flutter/cupertino.dart';
// import "package:flutter/material.dart";

// Widget _searchTextField(){
//   return TextField(
//     onChanged: (String s){
//       setState((){
//         _searchIndexList =[];
//         for(int i = 0;i<_list.length;i++){
//           if(_list[i].contains(s)){
//             _searchIndexList.add(i);
//           }
//         }
//       });
//     },
//     autofocus:true,
//     cursorColor: Colors.white,
//     style:TextStyle(
//       color: Colors.white,
//       fontSize: 20,
//     ),
//     textInputAction: TextInputAction.search,
//     decoration: InputDecoration(
//       enabledBorder: UnderlineInputBorder(
//         borderSide: BorderSide(
//           color: Colors.white,
//         )
//       ),
//       focusedBorder: UnderlineInputBorder(
//         borderSide: BorderSide(
//           color: Colors.white,
//         ),
//       ),
//         hintText:'Search',
//         hintStyle: TextStyle(
//           color: Colors.white,
//           fontSize: 20,
//         ),
//       ),
//     );
// }