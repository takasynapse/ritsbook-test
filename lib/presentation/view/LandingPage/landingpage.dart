import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:projectritsbook_native/data/datasources/bookremotedatasource.dart';
import 'package:projectritsbook_native/data/models/book_model.dart';
import 'package:projectritsbook_native/data/repository/userrepository.dart';
import 'package:projectritsbook_native/domain/usecases/get_book_use_case.dart';
import 'package:projectritsbook_native/presentation/view/LandingPage/book_item.dart';

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
