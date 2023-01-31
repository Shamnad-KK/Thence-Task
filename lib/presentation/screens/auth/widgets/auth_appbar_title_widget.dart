import 'package:flutter/material.dart';
import 'package:thence_task/theme/app_textstyle.dart';

class AuthAppbarTitleWidget extends StatelessWidget {
  const AuthAppbarTitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.title1,
    );
  }
}
