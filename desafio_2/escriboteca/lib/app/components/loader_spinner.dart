import 'package:flutter/material.dart';

class LoaderSpinner extends StatelessWidget {
  const LoaderSpinner({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: CircularProgressIndicator(
          strokeWidth: 6,
          color: color,
        ),
      ),
    );
  }
}
