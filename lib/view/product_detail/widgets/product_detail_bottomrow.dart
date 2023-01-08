import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_textstyle.dart';
import '../../../model/product_model.dart';

class ProductDetailBottomRow extends StatelessWidget {
  const ProductDetailBottomRow({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: size.height * 0.07,
            width: size.width * 0.15,
            decoration: BoxDecoration(
                color: AppColors.unselectedChip,
                borderRadius: BorderRadius.circular(16)),
            child: Consumer<HomeController>(
              builder: (context, value, child) => GestureDetector(
                onTap: () {
                  value.addOrRemoveFavorite(product);
                },
                child: Center(
                  child: product.isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: AppColors.red,
                          size: 28,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          size: 28,
                        ),
                ),
              ),
            ),
          ),
          Container(
            width: size.width * 0.7,
            height: size.height * 0.07,
            decoration: BoxDecoration(
                color: AppColors.selectedChip,
                borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: Text(
                'Add to cart',
                style:
                    AppTextStyle.bodyGreyText.copyWith(color: AppColors.white),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
