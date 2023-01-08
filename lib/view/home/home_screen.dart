import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thence_task/controller/home_controller.dart';
import 'package:thence_task/helpers/app_colors.dart';
import 'package:thence_task/helpers/app_spacing.dart';
import 'package:thence_task/helpers/app_textstyle.dart';
import 'package:thence_task/view/home/widgets/home_ad_widget.dart';
import 'package:thence_task/view/home/widgets/home_shimmers.dart';
import 'package:thence_task/widgets/headline_widget.dart';

import 'widgets/home_product_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size(size.width, size.height * 0.12),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.03, vertical: size.height * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All plants',
                        style: AppTextStyle.appbarTitle,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search, size: 30),
                      ),
                    ],
                  ),
                  const HeadlineWidget(text: 'Houseplants'),
                ],
              ),
            )),
        body: Consumer<HomeController>(
          builder: (context, value, child) {
            return value.isLoading
                ? const HomeShimmers()
                : SingleChildScrollView(
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
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return ChoiceChip(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          label: Text(value.choiceChips[index],
                                              style: AppTextStyle.bodyGreyText
                                                  .copyWith(
                                                color: value.selectedChip ==
                                                        index
                                                    ? AppColors.white
                                                    : AppColors.bodyGreyText,
                                              )),
                                          selectedColor: AppColors.selectedChip,
                                          disabledColor:
                                              AppColors.unselectedChip,
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
                              HomeProductsWidget(
                                products: value.products,
                              ),
                              SizedBox(height: size.height * 0.05),
                              const HomeAdWidget(),
                              SizedBox(height: size.height * 0.03),
                              HomeProductsWidget(
                                products: value.productBelowBanner,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
          },
        ));
  }
}
