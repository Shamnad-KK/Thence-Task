import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../theme/app_colors.dart';
import '../../../blocs/home/home_bloc.dart';

class ProductDetailImage extends StatelessWidget {
  const ProductDetailImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final product = state.product!;
        return CachedNetworkImage(
          width: size.width,
          height: size.height * 0.4,
          imageUrl: product.imageUrl!,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              gradient: AppColors.productDetailBg,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              image: DecorationImage(
                image: imageProvider,
              ),
            ),
          ),
        );

        // Container(
        //   width: size.width,
        //   height: size.height * 0.4,
        //   decoration: BoxDecoration(
        //     gradient: AppColors.productDetailBg,
        //     borderRadius: const BorderRadius.only(
        //       bottomLeft: Radius.circular(30),
        //       bottomRight: Radius.circular(30),
        //     ),
        //     image: DecorationImage(
        //       image: NetworkImage(product.imageUrl!),
        //     ),
        //   ),
        // );
      },
    );
  }
}
