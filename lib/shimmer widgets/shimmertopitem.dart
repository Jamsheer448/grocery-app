import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

class Shimmertopitem extends StatelessWidget {
  const Shimmertopitem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.rtl,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8, // Increased spacing
        crossAxisSpacing: 8, // Increased spacing
        children: List.generate(
          6, // Placeholder itemCount
          (index) => Padding(
            padding: EdgeInsets.all(8.0), // Increased padding
            child: Container(
              height: 200, // Increased height
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[100],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
