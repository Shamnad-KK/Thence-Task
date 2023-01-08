import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/product_detail_controller.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_spacing.dart';
import '../../../helpers/app_textstyle.dart';
import '../../../model/product_model.dart';
import '../../../widgets/headline_widget.dart';

class ProductDetailVariants extends StatelessWidget {
  const ProductDetailVariants({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              HeadlineWidget(text: product.name),
              Text("${product.price}\$", style: AppTextStyle.title1)
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            children: [
              const Icon(
                Icons.star,
                color: AppColors.rating,
                size: 12,
              ),
              AppSpacing.sboxW5,
              Text(product.rating, style: AppTextStyle.ratingText),
            ],
          ),
          SizedBox(height: size.height * 0.03),
          Text(
            "Choose size",
            style: AppTextStyle.productDetailTitle,
          ),
          SizedBox(height: size.height * 0.01),
          Consumer<ProductDetailController>(
            builder: (context, value, child) => SizedBox(
                height: size.height * 0.04,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ChoiceChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        label: Text(
                          "${product.sizes[index]} cm",
                          style: TextStyle(
                              color: value.selectedChip == index
                                  ? AppColors.white
                                  : AppColors.bodyGreyText,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        selectedColor: AppColors.selectedChip,
                        disabledColor: AppColors.unselectedChip,
                        selected: value.selectedChip == index,
                        onSelected: (_) {
                          value.changeChip(index);
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return AppSpacing.sboxW10;
                    },
                    itemCount: product.sizes.length)),
          ),
          SizedBox(height: size.height * 0.03),
          Text(
            "Description",
            style: AppTextStyle.productDetailTitle,
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            "At home, Echeveria feels great and looks great, and with proper care, even pleases with flowers.",
            style: AppTextStyle.labelSmall.copyWith(fontSize: 13),
          ),
          SizedBox(height: size.height * 0.05),
        ],
      ),
    );
  }
}
