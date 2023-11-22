import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/book_controller.dart';
import 'cover_book.dart';
import 'loader_spinner.dart';

class CardBook extends StatelessWidget {
  final BookController controller;

  const CardBook({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () async => controller.downloadAndOpenBook(),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    CoverBook(
                      coverUrl: controller.book.coverUrl,
                      isDownloaded: controller.book.isDownloaded.value,
                    ),
                    if (!controller.book.isDownloaded.value &&
                        !controller.isDownloading.value)
                      const Positioned.fill(
                        child: Icon(
                          Icons.file_download,
                          size: 50,
                          color: downloadItemsColor,
                        ),
                      ),
                    if (controller.isDownloading.value)
                      const LoaderSpinner(
                        color: downloadItemsColor,
                      )
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  controller.book.title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  controller.book.author,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Obx(
              () => GestureDetector(
                onTap: () => controller.toggleFavorite(),
                child: CircleAvatar(
                  backgroundColor: favoriteBackground,
                  child: Icon(
                    controller.book.isFavorite.value
                        ? Icons.bookmark
                        : Icons.bookmark_outline,
                    color: controller.book.isFavorite.value
                        ? favoriteActive
                        : favoriteInactive,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
