import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/core/app_spacing.dart';
import 'package:thence_task/core/pop_ups.dart';
import 'package:thence_task/presentation/blocs/auth/auth_bloc.dart';
import 'package:thence_task/presentation/blocs/login/login_bloc.dart';
import 'package:thence_task/presentation/screens/home_wrapper/home_wrapper.dart';
import 'package:thence_task/theme/app_colors.dart';

class OtpVerifyButtonWidget extends StatelessWidget {
  const OtpVerifyButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        log('otp listener called');
        if (state is Authenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomeWrapperScreen(),
            ),
            (route) => false,
          );
        } else if (state is AuthErrorState) {
          await AppPopUps.showToast(
            state.errorMessage,
            AppColors.errorColor,
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              state.timeRemaining != 0
                  ? ElevatedButton(
                      onPressed: () {
                        if (state.otp!.length == 6) {
                          loginBloc.add(VerifyOtpEvent());
                        }
                      },
                      child: const Text('Verify'),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        loginBloc.add(
                          LoginEvent(mobile: state.phone!),
                        );
                      },
                      child: const Text('Resend otp'),
                    ),
              AppSpacing.sboxW10,
              Text(state.timeRemaining.toString()),
            ],
          );
        },
      ),
    );
  }
}
