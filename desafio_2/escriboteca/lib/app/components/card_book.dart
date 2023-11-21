import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../models/book.dart';

class CardBook extends StatefulWidget {
  final Book book;

  const CardBook({super.key, required this.book});

  @override
  State<CardBook> createState() => _CardBookState();
}

class _CardBookState extends State<CardBook> {
  RxBool isFavorite = false.obs;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Column(
          children: [
            SizedBox(
              height: 200,
              width: 160,
              child: Image.network(
                widget.book.coverUrl,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.book.title,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.book.author,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        Obx(
          () => GestureDetector(
            onTap: () {
              isFavorite.value = !isFavorite.value;
            },
            child: isFavorite.value
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
    );
  }
}
