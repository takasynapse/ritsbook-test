import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:projectritsbook_native/domain/entities/book_model.dart';
import 'package:projectritsbook_native/presentation/pages/Chat/chat.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({Key? key, required this.selectedBook})
      : super(key: key);
  final Book selectedBook;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Center(
          child: Text(
            selectedBook.title,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
        Image(image: NetworkImage(selectedBook.imageUrl)),
        ListTile(
          title: Text(
            selectedBook.title,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ListTile(
          title: Text(
            "¥${selectedBook.price}",
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Inter",
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const ListTile(
          title: Text(
            '商品の説明',
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        ListTile(
          title: Text(
            selectedBook.description,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ListTile(),
        ElevatedButton(onPressed: (){
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) =>  ChatPage(selectedBook.documentID))
          );
        }, child: const Text('コメントする'))
      ]),
    );
  }
}
