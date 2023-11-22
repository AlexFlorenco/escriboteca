import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

import '../models/book.dart';

class BookController extends GetxController {
  final Book book;
  RxBool isDownloading = false.obs;

  BookController(this.book);

  @override
  void onInit() {
    super.onInit();
    book.loadDownloadedState();
    book.loadFavoriteState();
  }

  Future<void> downloadAndOpenBook() async {
    isDownloading.value = true;

    final dio = Dio();

    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = '${appDocDir!.path}/${book.id}.epub';
    File file = File(path);

    if (!File(path).existsSync()) {
      await file.create();
      await dio.download(
        book.downloadUrl,
        path,
        deleteOnError: true,
      );
    }

    VocsyEpub.setConfig(
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      nightMode: true,
      enableTts: true,
    );

    VocsyEpub.open(path);

    isDownloading.value = false;
    book.isDownloaded.value = true;
    book.saveDownloadedState();
  }

  Future<void> deleteBook() async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    String path = '${appDocDir!.path}/${book.id}.epub';

    if (await File(path).exists()) {
      await File(path).delete();
    }

    book.isDownloaded.value = false;
    book.saveDownloadedState();
  }

  void toggleFavorite() {
    book.isFavorite.value = !book.isFavorite.value;
    book.saveFavoriteState();
  }
}
