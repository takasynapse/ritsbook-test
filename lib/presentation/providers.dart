import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projectritsbook_native/data/datasources/bookremotedatasource.dart';
import 'package:projectritsbook_native/data/repository/bookrepository.dart';
import 'package:projectritsbook_native/domain/usecases/get_book_use_case.dart';
import 'package:riverpod/riverpod.dart';

import '../data/models/book_model.dart';
import '../domain/usecases/exhibition_book_usecase.dart';

//Firestoreのインスタンスを作成
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});
//Firestoreのインスタンスを使って、BookRepositoryを作成
final bookRepositoryProvider = Provider((ref) => BookRepositoryImpl(
    bookRemoteDataSource: BookRemoteDataSourceImpl(
        firebaseFirestore: ref.read(firebaseFirestoreProvider))));
//BookRepositoryを使って、GetAllBooksUseCaseを作成
final getAllBooksUseCaseProvider =
    Provider((ref) => GetAllBooksUseCase(ref.read(bookRepositoryProvider)));
//GetAllBooksUseCaseを使って、出品中のすべての本を取得
final bookFutureProvider = FutureProvider.autoDispose<List<Book>>((ref) async {
  return ref.read(getAllBooksUseCaseProvider).execute();
});
//BookRepositoryを使って、UploadBookUseCaseを作成
final uploadBookUseCaseProvider =
    Provider((ref) => ExhibitionBookUseCase(ref.read(bookRepositoryProvider)));
