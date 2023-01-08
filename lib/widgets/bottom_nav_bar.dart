import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thence_task/controller/bottom_nav_controller.dart';
import 'package:thence_task/helpers/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomNavController =
        Provider.of<BottomNavController>(context, listen: false);
    return Consumer<BottomNavController>(
      builder: (context, value, child) => Scaffold(
        body: value.pages[bottomNavController.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: value.currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(
                    const AssetImage('assets/bottom_nav_bar/home.png'),
                    color: value.currentIndex == 0
                        ? AppColors.black
                        : AppColors.bodyGreyText),
                label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    const AssetImage('assets/bottom_nav_bar/cart.png'),
                    color: value.currentIndex == 1
                        ? AppColors.black
                        : AppColors.bodyGreyText),
                label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    const AssetImage('assets/bottom_nav_bar/favorite.png'),
                    color: value.currentIndex == 2
                        ? AppColors.black
                        : AppColors.bodyGreyText),
                label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    const AssetImage('assets/bottom_nav_bar/profile.png'),
                    color: value.currentIndex == 3
                        ? AppColors.black
                        : AppColors.bodyGreyText),
                label: ''),
          ],
          onTap: (index) {
            value.changeIndex(index);
          },
        ),
      ),
    );
  }
}
