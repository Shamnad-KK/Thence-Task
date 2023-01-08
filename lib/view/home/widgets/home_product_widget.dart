import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thence_task/model/product_model.dart';

import '../../../controller/home_controller.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_spacing.dart';
import '../../../helpers/app_textstyle.dart';

class HomeProductsWidget extends StatelessWidget {
  const HomeProductsWidget({
    Key? key,
    required this.products,
  }) : super(key: key);
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeController = Provider.of<HomeController>(context, listen: false);
    return ListView.separated(
      itemCount: products.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            homeController.gotoProductDetail(context, product);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: size.height * 0.1,
                    width: size.width * 0.32,
                    decoration: BoxDecoration(
                      color: product.bgColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Container(
                    height: size.height * 0.13,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(product.image),
                          fit: BoxFit.fitHeight),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      padding: EdgeInsets.all(size.aspectRatio * 0.1),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          homeController.addOrRemoveFavorite(product);
                        },
                        child: Center(
                          child: product.isFavorite
                              ? const Icon(
                                  Icons.favorite,
                                  color: AppColors.red,
                                )
                              : const Icon(
                                  Icons.favorite_border,
                                  color: AppColors.bodyGreyText,
                                ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              AppSpacing.sboxW10,
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: size.height * 0.08,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(product.name, style: AppTextStyle.body1),
                          AppSpacing.sboxW20,
                          const Icon(
                            Icons.star,
                            color: AppColors.rating,
                            size: 12,
                          ),
                          Text(product.rating, style: AppTextStyle.ratingText),
                        ],
                      ),
                      Text("${product.sizes[0]} cm",
                          style: AppTextStyle.labelSmall),
                      Text(
                        "${product.price} \$",
                        style: AppTextStyle.labelSmall
                            .copyWith(color: AppColors.black),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: size.height * 0.05);
      },
    );
  }
}
