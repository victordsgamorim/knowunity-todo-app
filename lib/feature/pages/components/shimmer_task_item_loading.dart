import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTaskItem extends StatelessWidget {
  const ShimmerTaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 70,
      color: Colors.grey[100],
      child: ListTile(
        title: _shimmer(height: 15, width: double.maxFinite),
        subtitle: _shimmer(height: 10, width: double.maxFinite),
        trailing: _shimmer(height: 25, width: 25),
      ),
    );
  }

  Widget _shimmer({required double height, required double width}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.grey[300]!, borderRadius: BorderRadius.circular(4)),
      ),
    );
  }
}
