import 'package:flutter/material.dart';
import '../../../global/shimmer/shimmer_widget.dart';

Widget buildShimmerList(int itemCount) {
  return Column(
    children: List.generate(itemCount, (index) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: ShimmerWidget.circular(
            height: 70,
            shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)
            )
        ),
      );
    }),
  );
}