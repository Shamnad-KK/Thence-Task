import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/core/app_spacing.dart';
import 'package:thence_task/data/model/product_model.dart';
import 'package:thence_task/presentation/blocs/home/home_bloc.dart';
import 'package:thence_task/presentation/blocs/product_detail/product_detail_bloc.dart';
import 'package:thence_task/presentation/screens/product_detail/product_detail_screen.dart';
import 'package:thence_task/theme/app_colors.dart';
import 'package:thence_task/theme/app_textstyle.dart';

class HomeProductWidget extends StatelessWidget {
  const HomeProductWidget({super.key, required this.product});
  final ProductsModel product;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        BlocProvider.of<HomeBloc>(context)
            .add(SelectAProductEvent(product: product));

        BlocProvider.of<ProductDetailBloc>(context)
            .add(ChangeProductDetailChoiceChipEvent(
          index: 0,
        ));
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const ProductDetailScreen(),
        ));
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
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Container(
                height: size.height * 0.13,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        product.imageUrl!,
                      ),
                      fit: BoxFit.fitHeight),
                ),
              ),
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Positioned(
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
                          BlocProvider.of<HomeBloc>(context)
                              .add(AddorRemoveFavoriteEvent(id: product.id!));
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
                  );
                },
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
                      Text(product.name!, style: AppTextStyle.body1),
                      AppSpacing.sboxW20,
                      const Icon(
                        Icons.star,
                        color: AppColors.rating,
                        size: 12,
                      ),
                      Text(product.rating.toString(),
                          style: AppTextStyle.ratingText),
                    ],
                  ),
                  Text("${product.displaySize} cm",
                      style: AppTextStyle.labelSmall),
                  Text(
                    "${product.price} ${product.priceUnit}",
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
  }
}
