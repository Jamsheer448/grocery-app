import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ODshimmer extends StatelessWidget {
  const ODshimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
            // color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}

