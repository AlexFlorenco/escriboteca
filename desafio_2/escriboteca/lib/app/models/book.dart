import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Book {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;
  RxBool isFavorite = false.obs;
  RxBool isDownloaded = false.obs;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
  });

  static Book createBook(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      coverUrl: json['cover_url'],
      downloadUrl: json['download_url'],
    );
  }

  Future<void> saveDownloadedState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDownloaded$id', isDownloaded.value);
  }

  Future<void> loadDownloadedState() async {
    final prefs = await SharedPreferences.getInstance();
    isDownloaded.value = prefs.getBool('isDownloaded$id') ?? false;
  }

  Future<void> saveFavoriteState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFavorite$id', isFavorite.value);
  }

  Future<void> loadFavoriteState() async {
    final prefs = await SharedPreferences.getInstance();
    isFavorite.value = prefs.getBool('isFavorite$id') ?? false;
  }
}
