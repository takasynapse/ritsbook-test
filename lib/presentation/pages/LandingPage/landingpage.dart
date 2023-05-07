import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectritsbook_native/presentation/pages/LandingPage/book_item.dart';
import 'package:projectritsbook_native/presentation/providers.dart';


class LandingPage extends ConsumerWidget {
  const LandingPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureBooks = ref.watch(bookFutureProvider);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.white,
          ),
        ),
        body: futureBooks.when(
          data: (books) {
            return GridView.builder(
                itemCount: books.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 4,
                    childAspectRatio: 0.7),
                itemBuilder: (BuildContext context, int item) {
                  return BookItem(book: books[item]);
                });
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error:$error')),
        ));
  }
}
