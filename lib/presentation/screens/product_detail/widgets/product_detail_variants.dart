import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../theme/app_colors.dart';
import '../../../../core/app_spacing.dart';
import '../../../../theme/app_textstyle.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../blocs/product_detail/product_detail_bloc.dart';
import '../../../widgets/headline_widget.dart';

class ProductDetailVariants extends StatelessWidget {
  const ProductDetailVariants({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final product = state.product!;
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HeadlineWidget(text: product.name!),
                  Text("${product.price}\$", style: AppTextStyle.title1)
                ],
              ),
              SizedBox(height: size.height * 0.01),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.rating,
                    size: 12,
                  ),
                  AppSpacing.sboxW5,
                  Text("${product.rating}", style: AppTextStyle.ratingText),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                "Choose size",
                style: AppTextStyle.productDetailTitle,
              ),
              SizedBox(height: size.height * 0.01),
              SizedBox(
                  height: size.height * 0.04,
                  child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
                    builder: (context, state) {
                      return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return ChoiceChip(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              label: Text(
                                "${product.availableSize![index]} cm",
                                style: TextStyle(
                                    color: index == state.selectedChipIndex
                                        ? AppColors.white
                                        : AppColors.bodyGreyText,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                              selectedColor: AppColors.selectedChip,
                              disabledColor: AppColors.unselectedChip,
                              selected: index == state.selectedChipIndex,
                              onSelected: (_) {
                                BlocProvider.of<ProductDetailBloc>(context)
                                    .add(ChangeProductDetailChoiceChipEvent(
                                  index: index,
                                ));
                                // value.changeChip(index);
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return AppSpacing.sboxW10;
                          },
                          itemCount: product.availableSize!.length);
                    },
                  )),
              SizedBox(height: size.height * 0.03),
              Text(
                "Description",
                style: AppTextStyle.productDetailTitle,
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                "${product.description}",
                style: AppTextStyle.labelSmall.copyWith(fontSize: 13),
              ),
              SizedBox(height: size.height * 0.05),
            ],
          ),
        );
      },
    );
  }
}
