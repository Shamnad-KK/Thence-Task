import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thence_task/controller/home_controller.dart';
import 'package:thence_task/helpers/app_colors.dart';
import 'package:thence_task/helpers/app_spacing.dart';
import 'package:thence_task/helpers/app_textstyle.dart';
import 'package:thence_task/view/home/widgets/home_ad_widget.dart';
import 'package:thence_task/widgets/headline_widget.dart';

import 'widgets/home_product_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All plants',
          style: AppTextStyle.appbarTitle,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, size: 30),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeadlineWidget(text: 'Houseplants'),
              SizedBox(height: size.height * 0.03),
              Consumer<HomeController>(
                builder: (context, value, child) => SizedBox(
                    height: size.height * 0.04,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ChoiceChip(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            label: Text(value.choiceChips[index],
                                style: AppTextStyle.bodyGreyText.copyWith(
                                  color: value.selectedChip == index
                                      ? AppColors.white
                                      : AppColors.bodyGreyText,
                                )),
                            selectedColor: AppColors.selectedChip,
                            disabledColor: AppColors.unselectedChip,
                            selected: value.selectedChip == index,
                            onSelected: (_) {
                              value.changeChip(index);
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return AppSpacing.sboxW10;
                        },
                        itemCount: value.choiceChips.length)),
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
              const HomeProductsWidget(),
              SizedBox(height: size.height * 0.05),
              const HomeAdWidget(),
              SizedBox(height: size.height * 0.03),
              const HomeProductsWidget()
            ],
          ),
        ),
      ),
    );
  }
}
