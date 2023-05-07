import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectritsbook_native/data/datasources/bookremotedatasource.dart';
import 'package:projectritsbook_native/data/models/book_model.dart';
import 'package:projectritsbook_native/data/repository/userrepository.dart';
import 'package:projectritsbook_native/domain/usecases/get_book_use_case.dart';

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});
final bookRepositoryProvider = Provider((ref) => BookRepositoryImpl(
    bookRemoteDataSource: BookRemoteDataSourceImpl(
        firebaseFirestore: ref.read(firebaseFirestoreProvider))));
final getAllBooksUseCaseProvider =
    Provider((ref) => GetAllBooksUseCase(ref.read(bookRepositoryProvider)));
final bookFutureProvider = FutureProvider.autoDispose<List<Book>>((ref) async {
  return ref.read(getAllBooksUseCaseProvider).execute();
});

class LandingPageAfter extends ConsumerWidget {
  late Future<List<Book>> _futureBooks;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _futureBooks = ref.watch(bookFutureProvider);
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.white,
          ),
        ),
        body: _futureBooks.when(
          data: (books) {
            return ListView.builder(
                itemCount: books.length,
                itemBuilder: (BuildContext context, int item) {
                  return ListTile(
                    title: Text(books[item].title),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ItemDetailPage(books[item]),
                      //   ),
                      // );
                    },
                  );
                });
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error:$error')),
        ));
  }
}
