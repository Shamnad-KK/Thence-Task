import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/data/model/cart_product_model.dart';
import 'package:thence_task/presentation/blocs/cart/cart_bloc.dart';
import 'package:thence_task/theme/app_colors.dart';

class CartDeleteWidget extends StatelessWidget {
  const CartDeleteWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final CartProductModel product;

  @override
  Widget build(BuildContext context) {
    final CartBloc cartBloc = BlocProvider.of<CartBloc>(context);
    return IconButton(
      onPressed: () async {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Are you sure ?'),
              content: const Text('Do you want to remove?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    cartBloc.add(
                      RemoveProductFromCartEvent(
                        product: product,
                        id: product.id,
                      ),
                    );

                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(
        Icons.delete,
        color: AppColors.red,
      ),
    );
  }
}
