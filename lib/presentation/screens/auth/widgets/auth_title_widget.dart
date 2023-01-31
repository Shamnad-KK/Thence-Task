import 'package:flutter/material.dart';
import 'package:thence_task/theme/app_textstyle.dart';

class AuthTitleWidget extends StatelessWidget {
  const AuthTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.body1,
    );
  }
}
