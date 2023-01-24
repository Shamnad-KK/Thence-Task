import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/presentation/blocs/cart/cart_bloc.dart';
import 'package:thence_task/presentation/blocs/home/home_bloc.dart';
import 'package:thence_task/presentation/screens/cart/cart_screen.dart';
import 'package:thence_task/theme/app_colors.dart';

import '../blocs/bottom_nav/bottom_nav_bloc.dart';
import '../screens/home/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late final HomeBloc homeBloc;
  late final CartBloc cartBloc;
  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    cartBloc = BlocProvider.of<CartBloc>(context);
    homeBloc.add(GetProductsEvent());
    cartBloc.add(OnCartInit());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = const [
      HomeScreen(),
      CartScreen(),
      Center(
        child: Text('Favorites'),
      ),
      Center(
        child: Text('Profile'),
      ),
    ];
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          body: pages[state.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: state.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: ImageIcon(
                      const AssetImage('assets/bottom_nav_bar/home.png'),
                      color: state.currentIndex == 0
                          ? AppColors.black
                          : AppColors.bodyGreyText),
                  label: ''),
              BottomNavigationBarItem(
                  icon: BlocBuilder<CartBloc, CartState>(
                    builder: (context, cartState) {
                      return Stack(
                        children: [
                          ImageIcon(
                              const AssetImage(
                                  'assets/bottom_nav_bar/cart.png'),
                              color: state.currentIndex == 1
                                  ? AppColors.black
                                  : AppColors.bodyGreyText),
                          cartState.cartProducts.isNotEmpty
                              ? const CircleAvatar(
                                  radius: 4,
                                  backgroundColor: AppColors.red,
                                )
                              : const SizedBox(),
                        ],
                      );
                    },
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                      const AssetImage('assets/bottom_nav_bar/favorite.png'),
                      color: state.currentIndex == 2
                          ? AppColors.black
                          : AppColors.bodyGreyText),
                  label: ''),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                      const AssetImage('assets/bottom_nav_bar/profile.png'),
                      color: state.currentIndex == 3
                          ? AppColors.black
                          : AppColors.bodyGreyText),
                  label: ''),
            ],
            onTap: (index) {
              BlocProvider.of<BottomNavBloc>(context)
                  .add(ChangeBottomNav(newIndex: index));
            },
          ),
        );
      },
    );
  }
}