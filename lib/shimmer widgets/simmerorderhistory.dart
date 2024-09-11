import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerOH extends StatelessWidget {
  const ShimmerOH({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5, // Placeholder count
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
            ),
          );
        },
      ),
    );
  }
}
