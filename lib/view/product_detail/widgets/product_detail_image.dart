import 'package:flutter/material.dart';

import '../../../helpers/app_colors.dart';
import '../../../model/product_model.dart';

class ProductDetailImage extends StatelessWidget {
  const ProductDetailImage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.4,
      decoration: BoxDecoration(
        // color: Colors.transparent,
        gradient: AppColors.productDetailBg,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        image: DecorationImage(
          image: AssetImage(product.image),
        ),
      ),
    );
  }
}
