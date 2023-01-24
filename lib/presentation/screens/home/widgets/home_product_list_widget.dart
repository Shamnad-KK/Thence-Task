import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/presentation/screens/home/widgets/home_ad_widget.dart';
import 'package:thence_task/presentation/screens/home/widgets/home_product_widget.dart';

import '../../../blocs/home/home_bloc.dart';

class HomeProductList extends StatelessWidget {
  const HomeProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.products!.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final product = state.products![index];
            return index == 2
                ? Column(
                    children: [
                      const HomeAdWidget(),
                      HomeProductWidget(product: product),
                    ],
                  )
                : HomeProductWidget(product: product);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: size.height * 0.05);
          },
        );
      },
    );
  }
}
