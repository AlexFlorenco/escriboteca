import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/card_book.dart';
import '../controllers/book_controller.dart';
import '../models/book.dart';
import '../repositories/books_repository.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key, required this.booksRepository});
  final BooksRepository booksRepository;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          crossAxisCount: 2,
          childAspectRatio: 0.6,
        ),
        itemCount:
            booksRepository.books.where((book) => book.isFavorite.value).length,
        itemBuilder: (context, index) {
          Book book = booksRepository.books
              .where((book) => book.isFavorite.value)
              .toList()[index];
          String controllerName = 'bookController${book.id}';
          Get.put(BookController(book), tag: controllerName);
          return CardBook(
            controller: Get.find<BookController>(tag: controllerName),
          );
        },
      ),
    );
  }
}
