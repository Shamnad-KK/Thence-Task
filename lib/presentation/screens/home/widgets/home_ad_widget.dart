import 'package:flutter/material.dart';

import '../../../../theme/app_colors.dart';
import '../../../../core/app_spacing.dart';
import '../../../../theme/app_textstyle.dart';

class HomeAdWidget extends StatelessWidget {
  const HomeAdWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.125,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: size.width,
            height: size.height * 0.12,
            decoration: BoxDecoration(
              gradient: AppColors.homeBanner,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            left: 30,
            top: 0,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Free shipping',
                  style: AppTextStyle.body2,
                ),
                AppSpacing.sboxH5,
                Row(
                  children: [
                    Text(
                      'on orders',
                      style: AppTextStyle.labelSmall,
                    ),
                    SizedBox(width: size.width * 0.004),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                        vertical: size.height * 0.003,
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.rating,
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          'over \$100',
                          style: AppTextStyle.labelSmall
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            right: 50,
            child: Image.asset(
              'assets/Saly-3.png',
              scale: 1.9,
            ),
          )
        ],
      ),
    );
  }
}
