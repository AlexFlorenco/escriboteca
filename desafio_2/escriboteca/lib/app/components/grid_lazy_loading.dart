import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants.dart';

class GridLazyLoading extends StatelessWidget {
  const GridLazyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Shimmer.fromColors(
        baseColor: baseLazyLoadingColor,
        highlightColor: highlightLazyLoadingColor,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 16,
            crossAxisCount: 2,
            childAspectRatio: 0.6,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 200,
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey,
                  ),
                  height: 15,
                  width: 100,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.grey,
                  ),
                  height: 15,
                  width: 160,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
