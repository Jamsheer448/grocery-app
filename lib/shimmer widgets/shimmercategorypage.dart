import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class shimmercategory extends StatelessWidget {
  

  const shimmercategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      direction: ShimmerDirection.rtl,
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        padding: const EdgeInsets.all(4.0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.95,
                height: 60,
                color: Colors.grey.shade200,
              ),
            ),
          );
        },
      ),
    );
  }
}
