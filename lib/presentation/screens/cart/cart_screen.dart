import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/presentation/blocs/cart/cart_bloc.dart';
import 'package:thence_task/presentation/screens/cart/widgets/cart_delete_widget.dart';
import 'package:thence_task/presentation/screens/cart/widgets/cart_product_widget.dart';
import 'package:thence_task/theme/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    //cartBloc.add(GetAllCartProductsEvent());
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return state.cartProducts.isEmpty
                      ? const Center(
                          child: Text('Cart empty'),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) {
                                  final product = state.cartProducts[index];
                                  return Row(
                                    children: [
                                      Expanded(
                                        child:
                                            CartProductWidget(product: product),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              cartBloc.add(
                                                DecreaseProductQuantity(
                                                  id: product.id,
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                          Text(product.count.toString()),
                                          IconButton(
                                            onPressed: () {
                                              cartBloc.add(
                                                IncreaseProductQuantity(
                                                  id: product.id,
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                      CartDeleteWidget(product: product)
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: size.height * 0.05);
                                },
                                itemCount: state.cartProducts.length,
                              ),
                            ),
                            Container(
                              height: size.height * 0.08,
                              width: size.width,
                              padding: const EdgeInsets.all(12),
                              alignment: Alignment.centerLeft,
                              decoration:
                                  const BoxDecoration(color: AppColors.rating),
                              child: Text(
                                  'Total price: \$${state.totalPrice.abs()}'),
                            )
                          ],
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
