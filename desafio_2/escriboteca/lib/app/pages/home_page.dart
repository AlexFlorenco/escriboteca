import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/card_book.dart';
import '../constants.dart';
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
              title: const Text('ESCRIBOTECA'),
              bottom: const TabBar(
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
              padding: const EdgeInsets.all(16.0),
              child: TabBarView(children: [
                booksRepository.isLoading.value
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(primaryColor),
                            ),
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
                          return CardBook(book: book);
                        },
                      ),
                Placeholder(),
              ]),
            ),
          )),
    );
  }
}
