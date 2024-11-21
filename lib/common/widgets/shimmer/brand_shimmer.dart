import 'package:flutter/material.dart';

import '../layouts/gid_layout.dart';
import 'shimmer.dart';

class BrandShimmer extends StatelessWidget {
  const BrandShimmer({super.key, this.itemCount = 4});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return PGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const PShimmerEffect(height: 80, width: 300),
    );
  }
}
