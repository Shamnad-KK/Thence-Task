import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_controller.dart';
import '../../../helpers/app_colors.dart';
import '../../../helpers/app_spacing.dart';
import '../../../helpers/app_textstyle.dart';

class HomeProductsWidget extends StatelessWidget {
  const HomeProductsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<HomeController>(
      builder: (context, value, child) {
        return ListView.separated(
          itemCount: value.products.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final product = value.products[index];
            return GestureDetector(
              onTap: () {
                value.gotoProductDetail(context, product);
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
                          child: const Center(
                            child: Icon(
                              Icons.favorite_border,
                              color: AppColors.bodyGreyText,
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
                              Text(product.rating,
                                  style: AppTextStyle.ratingText),
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
      },
    );
  }
}
