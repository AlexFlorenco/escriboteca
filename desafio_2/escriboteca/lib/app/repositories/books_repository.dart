import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/book.dart';

const String urlApi = 'https://escribo.com/books.json';

class BooksRepository {
  final List<Book> _books = [];
  Set<int> bookIds = {};
  RxBool isLoading = false.obs;

  final Dio dio;

  BooksRepository({required this.dio});

  Future<dynamic> getBooksAPI() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    try {
      var response = await dio.get(urlApi);
      if (response.statusCode == 200) {
        List<dynamic> json = response.data;

        for (var bookJson in json) {
          if (!bookIds.contains(bookJson["id"])) {
            Book book = Book.createBook(bookJson);
            bookIds.add(book.id);
            _books.add(book);
          }
        }
        isLoading.value = false;

        return true;
      } else {
        return false;
        // throw Exception('Falha ao carregar biblioteca');
      }
    } catch (e) {
      // isLoading.value = false;
      return false;
      // throw Exception('Falha ao carregar biblioteca: $e');
    }
  }

  List<Book> get books => _books;
}
