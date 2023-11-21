import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/book.dart';

const String urlApi = 'https://escribo.com/books.json';

class BooksRepository {
  List<Book> _books = [];
  RxBool isLoading = false.obs;

  final Dio dio;

  BooksRepository({required this.dio});

  Future<dynamic> getBooksAPI() async {
    isLoading.value = true;
    try {
      var response = await dio.get(urlApi);
      if (response.statusCode == 200) {
        List<dynamic> json = response.data;
        _books = json.map((e) => Book.createBook(e)).toList();
        print(json);
        isLoading.value = false;
        return true;
      } else {
        throw Exception('Falha ao carregar biblioteca');
      }
    } catch (e) {
      isLoading.value = false;
      throw Exception('Falha ao carregar biblioteca: $e');
    }
  }

  List<Book> get books => _books;
}
