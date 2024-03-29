import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:projectritsbook_native/domain/entities/book_model/book_model.dart';
import 'package:projectritsbook_native/presentation/pages/book_detail/book_detail_page.dart';

class BookItem extends StatefulWidget {
  final Book book;
  const BookItem({Key? key, required this.book}) : super(key: key);
  @override
  BookItemState createState() => BookItemState();
}

class BookItemState extends State<BookItem> {
  BookItemState({Key? key});
  final _key = GlobalKey();
  double height = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        height = _key.currentContext!.size!.height;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailPage(selectedBook: book),
          ),
        );
      },
      child: Card(
          key: _key,
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shape: const RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(10),
              ),
          child: (book.isSold)
              ? Column(
                  children: [
                    Container(
                      color: Colors.grey[300],
                      width: double.infinity,
                      height: height * 0.75,
                      child: CachedNetworkImage(
                        imageUrl: book.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                      child: SizedBox(
                        height: height * 0.1,
                        width: double.infinity,
                        child: Opacity(
                          opacity: 0.8,
                          child: Text(
                            book.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        height: height * 0.1,
                        width: double.infinity,
                        child: Opacity(
                          opacity: 0.8,
                          child: Text(
                            "¥${book.price}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              :
              //売り切れの商品は画像をグレーにする
              Stack(children: [
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: height * 0.75,
                        child: Image.network(
                          book.imageUrl,
                          fit: BoxFit.cover,
                          color: Colors.grey,
                          colorBlendMode: BlendMode.saturation,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                        child: SizedBox(
                          height: height * 0.1,
                          width: double.infinity,
                          child: Text(
                            book.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: SizedBox(
                          height: height * 0.1,
                          width: double.infinity,
                          child: Opacity(
                            opacity: 0.8,
                            child: Text(
                              "¥${book.price}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                fontFamily: "Inter",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Center(
                      child: Padding(
                    padding: EdgeInsets.only(bottom: 40.0),
                    child: Text(
                      "SOLD",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                ])),
    );
  }
}
