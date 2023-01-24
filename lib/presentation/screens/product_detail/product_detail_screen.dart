import 'package:flutter/material.dart';

import 'widgets/product_detail_bottomrow.dart';
import 'widgets/product_detail_image.dart';
import 'widgets/product_detail_variants.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: const [
                ProductDetailImage(),
                ProductDetailVariants(),
              ],
            ),
          ),
          const ProductDetailBottomRow(),
        ],
      ),
    );
  }
}
