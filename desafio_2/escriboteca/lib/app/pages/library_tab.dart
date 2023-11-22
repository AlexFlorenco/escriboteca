import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/card_book.dart';
import '../controllers/book_controller.dart';
import '../models/book.dart';
import '../repositories/books_repository.dart';

class LibraryTab extends StatelessWidget {
  const LibraryTab({super.key, required this.booksRepository});
  final BooksRepository booksRepository;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await booksRepository.getBooksAPI();
      },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 16,
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 4,
          childAspectRatio: 0.6,
        ),
        itemCount: booksRepository.books.length,
        itemBuilder: (context, index) {
          Book book = booksRepository.books[index];
          String controllerName = 'bookController${book.id}';
          Get.put(BookController(book), tag: controllerName);
          return Center(
            child: CardBook(
              controller: Get.find<BookController>(tag: controllerName),
            ),
          );
        },
      ),
    );
  }
}
