import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/book_controller.dart';
import 'cover_book.dart';

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
                CoverBook(
                  controller: controller,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 133,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 30,
                      child: IconButton(
                          onPressed: () {
                            controller.deleteBook();
                          },
                          icon: controller.book.isDownloaded.value
                              ? const Icon(
                                  Icons.file_download_off,
                                  color: downloadItemsColor,
                                )
                              : const Icon(null)),
                    )
                  ],
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
