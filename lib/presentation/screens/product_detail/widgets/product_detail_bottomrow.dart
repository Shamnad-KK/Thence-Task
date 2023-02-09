import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/core/pop_ups.dart';
import 'package:thence_task/data/model/cart_product_model.dart';
import 'package:thence_task/data/model/product_model.dart';
import 'package:thence_task/presentation/blocs/cart/cart_bloc.dart';
import 'package:thence_task/presentation/widgets/add_or_remove_favorite_widget.dart';
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
        final product = state.selectedProduct!;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AddorRemoveFavoriteWidget(
                  product: product,
                  height: size.height * 0.07,
                  width: size.width * 0.15,
                ),
                GestureDetector(
                  onTap: () {
                    _addOrRemoveFromCart(product, cartBloc);
                  },
                  child: BlocListener<CartBloc, CartState>(
                    listener: (context, state) async {
                      await AppPopUps.showToast(
                        'Product added to cart',
                        AppColors.successColor,
                      );
                    },
                    child: Container(
                      width: size.width * 0.7,
                      height: size.height * 0.07,
                      decoration: BoxDecoration(
                        color: AppColors.selectedChip,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Add to cart',
                          style: AppTextStyle.bodyGreyText
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _addOrRemoveFromCart(
    ProductsModel product,
    CartBloc cartBloc,
  ) {
    final cartProduct = CartProductModel(
        id: product.id!,
        image: product.imageUrl!,
        name: product.name!,
        price: double.parse(product.price!),
        priceUnit: product.priceUnit!);
    cartBloc.add(
      AddProductToCartEvent(product: cartProduct),
    );
  }
}
