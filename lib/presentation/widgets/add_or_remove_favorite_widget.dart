import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/data/model/product_model.dart';
import 'package:thence_task/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:thence_task/theme/app_colors.dart';

class AddorRemoveFavoriteWidget extends StatelessWidget {
  const AddorRemoveFavoriteWidget({
    Key? key,
    required this.product,
    required this.height,
    required this.width,
    this.iconSize = 28,
    this.bgColor = AppColors.unselectedChip,
    this.circularRadius = 16,
  }) : super(key: key);

  final ProductsModel product;
  final double height;
  final double width;
  final double? iconSize;
  final Color? bgColor;
  final double circularRadius;

  @override
  Widget build(BuildContext context) {
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        int index = state.favoriteList!.indexWhere(
          (element) => element.id == product.id,
        );
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(circularRadius),
          ),
          child: GestureDetector(
            onTap: () {
              favoritesBloc.add(
                AddToFavoriteEvent(product: product),
              );
            },
            child: Center(
              child: index != -1
                  ? Icon(
                      Icons.favorite,
                      color: AppColors.red,
                      size: iconSize,
                    )
                  : Icon(
                      Icons.favorite_border,
                      size: iconSize,
                    ),
            ),
          ),
        );
      },
    );
  }
}
