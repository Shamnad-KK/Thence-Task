import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_spacing.dart';
import '../../../../theme/app_colors.dart';
import '../../../../theme/app_textstyle.dart';
import '../../../blocs/home_choice_chips/home_choice_chips_bloc.dart';

class HomeChoiceChips extends StatelessWidget {
  const HomeChoiceChips({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeChoiceChipsBloc, HomeChoiceChipsState>(
      builder: (context, homeChoiceChipState) {
        return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ChoiceChip(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                label: Text(homeChoiceChipState.choiceChips[index],
                    style: AppTextStyle.bodyGreyText.copyWith(
                      color: homeChoiceChipState.selectedChipIndex == index
                          ? AppColors.white
                          : AppColors.bodyGreyText,
                    )),
                selectedColor: AppColors.selectedChip,
                disabledColor: AppColors.unselectedChip,
                selected: homeChoiceChipState.selectedChipIndex == index,
                onSelected: (_) {
                  BlocProvider.of<HomeChoiceChipsBloc>(context)
                      .add(ChangeHomeChoiceChip(index: index));
                },
              );
            },
            separatorBuilder: (context, index) {
              return AppSpacing.sboxW20;
            },
            itemCount: homeChoiceChipState.choiceChips.length);
      },
    );
  }
}
