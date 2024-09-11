import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class shimmeruser extends StatelessWidget {
  const shimmeruser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.rtl,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 24,
                    color: Colors.grey.shade200,
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 150,
                    height: 16,
                    color: Colors.grey.shade200,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
