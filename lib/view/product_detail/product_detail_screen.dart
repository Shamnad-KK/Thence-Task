import 'package:flutter/material.dart';
import 'package:thence_task/model/product_model.dart';

import 'widgets/product_detail_bottomrow.dart';
import 'widgets/product_detail_image.dart';
import 'widgets/product_detail_variants.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
  });
  final ProductModel product;

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
              children: [
                ProductDetailImage(product: product),
                ProductDetailVariants(product: product)
              ],
            ),
          ),
          ProductDetailBottomRow(product: product)
        ],
      ),
    );
  }
}
