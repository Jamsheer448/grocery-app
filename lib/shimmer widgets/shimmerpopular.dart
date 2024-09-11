import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Shimmerpopular extends StatelessWidget {
  const Shimmerpopular({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
            direction: ShimmerDirection.rtl,
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Placeholder for shimmer
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  );
                },
              ),
            ));
}}