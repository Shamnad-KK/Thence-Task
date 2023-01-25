import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/presentation/blocs/favorites/favorites_bloc.dart';
import 'package:thence_task/presentation/screens/home/widgets/home_product_widget.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            return state.favoriteList!.isEmpty
                ? const Center(
                    child: Text('No Favorites'),
                  )
                : ListView.separated(
                    itemCount: state.favoriteList!.length,
                    itemBuilder: (context, index) {
                      final product = state.favoriteList![index];
                      return HomeProductWidget(product: product);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: size.height * 0.05);
                    },
                  );
          },
        ),
      ),
    );
  }
}
