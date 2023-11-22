import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/book_controller.dart';

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
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 160,
                      child: Opacity(
                        opacity: controller.book.isDownloaded.value ? 1.0 : 0.5,
                        child: Image.network(
                          controller.book.coverUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
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
                      const Positioned.fill(
                        child: Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              strokeWidth: 6,
                              color: downloadItemsColor,
                            ),
                          ),
                        ),
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
                child: controller.book.isFavorite.value
                    ? const CircleAvatar(
                        backgroundColor: favoriteBackground,
                        child: Icon(
                          Icons.bookmark,
                          color: favoriteActive,
                          size: 30,
                        ),
                      )
                    : const CircleAvatar(
                        backgroundColor: favoriteBackground,
                        child: Icon(
                          Icons.bookmark_outline,
                          color: favoriteInactive,
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
