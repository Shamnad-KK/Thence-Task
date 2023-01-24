import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/data/model/cart_product_model.dart';
import 'package:thence_task/presentation/blocs/cart/cart_bloc.dart';

import '../../../../theme/app_colors.dart';
import '../../../../theme/app_textstyle.dart';
import '../../../blocs/home/home_bloc.dart';

class ProductDetailBottomRow extends StatelessWidget {
  const ProductDetailBottomRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final product = state.product!;
        return Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  return Container(
                    height: size.height * 0.07,
                    width: size.width * 0.15,
                    decoration: BoxDecoration(
                        color: AppColors.unselectedChip,
                        borderRadius: BorderRadius.circular(16)),
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
                                size: 28,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                size: 28,
                              ),
                      ),
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  final cartProduct = CartProductModel(
                      id: product.id!,
                      image: product.imageUrl!,
                      name: product.name!,
                      price: double.parse(product.price!),
                      priceUnit: product.priceUnit!);
                  cartBloc.add(
                    AddProductToCartEvent(product: cartProduct),
                  );
                },
                child: Container(
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
                ),
              )
            ],
          ),
        ));
      },
    );
  }
}
