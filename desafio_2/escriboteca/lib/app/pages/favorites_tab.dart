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
      () => booksRepository.books
              .where((book) => book.isFavorite.value)
              .toList()
              .isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/images/empty_state.png',
                  opacity: const AlwaysStoppedAnimation(0.6),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Nenhum resultado encontrado.\nExperimente favoritar um livro.',
                  style: TextStyle(color: Colors.black54),
                )
              ],
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 16,
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 2
                        : 4,
                childAspectRatio: 0.6,
              ),
              itemCount: booksRepository.books
                  .where((book) => book.isFavorite.value)
                  .length,
              itemBuilder: (context, index) {
                Book book = booksRepository.books
                    .where((book) => book.isFavorite.value)
                    .toList()[index];
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
