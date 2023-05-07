import 'package:flutter/material.dart';
import 'package:projectritsbook_native/data/models/book_model.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({Key? key, required this.selectedBook})
      : super(key: key);
  final Book selectedBook;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
        child: Column(children: [
          Image(image: NetworkImage(selectedBook.imageUrl)),
          Text(selectedBook.title),
          Text(selectedBook.author),
          Text(selectedBook.price.toString()),
          Text(selectedBook.description),
        ]),
      ),
    );
  }
}
