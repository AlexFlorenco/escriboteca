import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controllers/book_controller.dart';
import 'loader_spinner.dart';

class CoverBook extends StatelessWidget {
  const CoverBook({super.key, required this.controller});
  final BookController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Container(
            height: 200,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(controller.book.coverUrl),
                fit: BoxFit.fill,
                opacity: controller.book.isDownloaded.value ? 1.0 : 0.5,
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
              child: LoaderSpinner(
                color: downloadItemsColor,
              ),
            )
        ],
      ),
    );
  }
}
