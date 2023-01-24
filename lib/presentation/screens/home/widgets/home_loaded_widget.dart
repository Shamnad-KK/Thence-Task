import 'package:flutter/material.dart';
import 'package:thence_task/presentation/screens/home/widgets/home_choice_chip_widget.dart';
import 'package:thence_task/presentation/screens/home/widgets/home_product_list_widget.dart';
import 'package:thence_task/theme/app_colors.dart';
import 'package:thence_task/theme/app_textstyle.dart';

class HomeLoadedWidget extends StatelessWidget {
  const HomeLoadedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.04,
                  child: const HomeChoiceChips(),
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  children: [
                    Text(
                      'By popularity',
                      style: AppTextStyle.labelSmall,
                    ),
                    const Icon(
                      Icons.arrow_downward,
                      color: AppColors.bodyGreyText,
                      size: 18,
                    )
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                const HomeProductList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
