import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:thence_task/core/app_spacing.dart';
import 'package:thence_task/presentation/blocs/auth/auth_bloc.dart';
import 'package:thence_task/presentation/screens/auth/widgets/auth_title_widget.dart';
import 'package:thence_task/presentation/screens/auth/widgets/otp_verify_button_widget.dart';
import 'package:thence_task/theme/app_colors.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('build called');
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AuthTitleWidget(title: 'Enter the OTP'),
            OtpTextField(
              numberOfFields: 6,
              focusedBorderColor: AppColors.black,
              enabledBorderColor: AppColors.bodyGreyText,
              onSubmit: (value) {
                BlocProvider.of<AuthBloc>(context).add(
                  GetCodeEvent(otp: value),
                );
              },
            ),
            AppSpacing.sboxH20,
            const OtpVerifyButtonWidget()
          ],
        ),
      ),
    );
  }
}
