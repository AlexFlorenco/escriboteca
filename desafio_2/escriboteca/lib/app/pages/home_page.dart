import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/card_book.dart';
import '../components/loader_spinner.dart';
import '../constants.dart';
import '../controllers/book_controller.dart';
import '../models/book.dart';
import '../repositories/books_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Dio dio = Dio();

  late final BooksRepository booksRepository;

  Future<void> deleteAllBooks() async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final dir = Directory(appDocDir!.path);

    if (dir.existsSync()) {
      dir.listSync().forEach((file) {
        if (file.path.endsWith('.epub')) {
          file.deleteSync();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    booksRepository = BooksRepository(dio: dio);
    booksRepository.getBooksAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              actions: [
                GestureDetector(
                    child: const Icon(Icons.delete),
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      deleteAllBooks();
                      prefs.clear();
                    })
              ],
              title: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.book),
                    text: 'Biblioteca',
                  ),
                  Tab(
                    icon: Icon(Icons.bookmarks),
                    text: 'Favoritos',
                  ),
                ],
                indicatorColor: whiteText,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: TabBarView(children: [
                booksRepository.isLoading.value
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LoaderSpinner(color: primaryColor),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Carregando estante...'),
                            )
                          ],
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 16,
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: booksRepository.books.length,
                        itemBuilder: (context, index) {
                          Book book = booksRepository.books[index];
                          String controllerName = 'bookController${book.id}';
                          Get.put(BookController(book), tag: controllerName);
                          return CardBook(
                            controller:
                                Get.find<BookController>(tag: controllerName),
                          );
                        },
                      ),
                GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 16,
                    crossAxisCount: 2,
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
                    return CardBook(
                      controller: Get.find<BookController>(tag: controllerName),
                    );
                  },
                ),
              ]),
            ),
          )),
    );
  }
}
