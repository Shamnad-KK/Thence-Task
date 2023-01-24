import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/core/app_spacing.dart';
import 'package:thence_task/data/model/cart_product_model.dart';
import 'package:thence_task/presentation/blocs/product_detail/product_detail_bloc.dart';
import 'package:thence_task/presentation/screens/product_detail/product_detail_screen.dart';
import 'package:thence_task/theme/app_colors.dart';
import 'package:thence_task/theme/app_textstyle.dart';

class CartProductWidget extends StatelessWidget {
  const CartProductWidget({super.key, required this.product});
  final CartProductModel product;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        // BlocProvider.of<HomeBloc>(context)
        //     .add(SelectAProductEvent(product: product));

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
          Container(
            height: size.height * 0.13,
            width: size.width * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    product.image,
                  ),
                  fit: BoxFit.fitHeight),
            ),
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
                  Text(product.name, style: AppTextStyle.body1),
                  Text(
                    "${product.priceUnit} ${product.price}",
                    style: AppTextStyle.labelSmall
                        .copyWith(fontSize: 13)
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
