import 'package:flutter/material.dart';

class CoverBook extends StatelessWidget {
  const CoverBook(
      {super.key, required this.coverUrl, required this.isDownloaded});
  final String coverUrl;
  final bool isDownloaded;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(coverUrl),
          fit: BoxFit.fill,
          opacity: isDownloaded ? 1.0 : 0.5,
        ),
      ),
    );
  }
}
