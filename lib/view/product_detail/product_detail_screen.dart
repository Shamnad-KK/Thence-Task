import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thence_task/controller/product_detail_controller.dart';
import 'package:thence_task/helpers/app_colors.dart';
import 'package:thence_task/helpers/app_textstyle.dart';
import 'package:thence_task/model/product_model.dart';
import 'package:thence_task/widgets/headline_widget.dart';

import '../../helpers/app_spacing.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({
    super.key,
    required this.product,
  });
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                ),
                Padding(
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                )
              ],
            ),
          ),
          Expanded(
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
                  child: const Center(
                    child: Icon(
                      Icons.favorite_border,
                      size: 28,
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
                      style: AppTextStyle.bodyGreyText
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
