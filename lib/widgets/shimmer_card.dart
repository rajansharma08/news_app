// lib/widgets/shimmer_card.dart
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFF464646),
      highlightColor: const Color(0xFF888888),
      child: Container(
        height: 180,
        margin: const EdgeInsets.only(bottom: 12),
        color: const Color(0xFF464646),
      ),
    );
  }
}