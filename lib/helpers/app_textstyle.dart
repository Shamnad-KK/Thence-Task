import 'package:flutter/cupertino.dart';
import 'package:thence_task/helpers/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static final appbarTitle = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.appbarTitle,
  );
  static final title1 = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  static final productDetailTitle = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );
  static final headline1 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.w900,
    color: AppColors.black,
  );
  static final bodyGreyText =
      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold);

  static final labelSmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.bodyGreyText,
  );

  static final ratingText = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.rating,
  );
  static final body1 = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static final body2 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );
}
