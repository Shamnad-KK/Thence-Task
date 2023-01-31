import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:thence_task/core/app_spacing.dart';
import 'package:thence_task/presentation/blocs/auth/auth_bloc.dart';
import 'package:thence_task/presentation/screens/auth/widgets/auth_title_widget.dart';
import 'package:thence_task/presentation/widgets/bottom_nav_bar.dart';
import 'package:thence_task/presentation/widgets/custom_text_field.dart';
import 'package:thence_task/theme/app_colors.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final usernameController = TextEditingController();
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
                authBloc.add(
                  GetCodeEvent(otp: value),
                );
              },
            ),
            AppSpacing.sboxH20,
            BlocConsumer<AuthBloc, AuthState>(
              listenWhen: (previous, current) {
                return current.status == AuthStatus.loaded &&
                    previous.timeRemaining == current.timeRemaining;
              },
              listener: (context, state) {
                if (state.userExists == false) {
                  log('user doesnt exist in firestore');
                  _addUser(context, usernameController);
                } else {
                  log('user exist in firestore');

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BottomNavBar(),
                    ),
                  );
                  authBloc.add(SetAuthResponseEvent());
                }
              },
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state.timeRemaining != 0
                        ? ElevatedButton(
                            onPressed: () {
                              authBloc.add(
                                  CheckUserExistEvent(phone: state.phone!));

                              if (state.otp!.length == 6) {
                                authBloc.add(VerifyOtpEvent());
                              }
                            },
                            child: const Text('Verify'),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              authBloc.add(LoginEvent(mobile: state.phone!));
                            },
                            child: const Text('Resend otp'),
                          ),
                    AppSpacing.sboxW10,
                    Text(state.timeRemaining.toString()),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _addUser(
    BuildContext context,
    TextEditingController usernameController,
  ) async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter username'),
          content: CustomTextField(
            controller: usernameController,
            hint: 'Name',
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                authBloc.add(
                  SaveUserDetailsEvent(username: usernameController.text),
                );
                authBloc.add(SetAuthResponseEvent());
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BottomNavBar(),
                  ),
                );
              },
              child: const Text('Save'),
            )
          ],
        );
      },
    );
  }
}
