import 'package:flutter/cupertino.dart';
import 'package:thence_task/theme/app_textstyle.dart';

class HeadlineWidget extends StatelessWidget {
  const HeadlineWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyle.headline1,
    );
  }
}
