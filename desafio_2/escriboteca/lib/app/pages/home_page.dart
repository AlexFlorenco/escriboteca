import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/grid_lazy_loading.dart';
import '../constants.dart';
import '../repositories/books_repository.dart';
import 'favorites_tab.dart';
import 'library_tab.dart';

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
            backgroundColor: primaryColor,
            appBar: AppBar(
              toolbarHeight: 70,
              backgroundColor: primaryColor,
              elevation: 0,
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
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16)),
                color: whiteText,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
                child: TabBarView(children: [
                  booksRepository.isLoading.value
                      ? const GridLazyLoading()
                      : LibraryTab(booksRepository: booksRepository),
                  FavoriteTab(booksRepository: booksRepository),
                ]),
              ),
            ),
          )),
    );
  }
}
