import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/core/app_spacing.dart';
import 'package:thence_task/presentation/blocs/login/login_bloc.dart';
import 'package:thence_task/presentation/blocs/user_check/user_check_bloc.dart';
import 'package:thence_task/presentation/widgets/bottom_nav_bar.dart';
import 'package:thence_task/presentation/widgets/custom_text_field.dart';

class HomeWrapperScreen extends StatelessWidget {
  const HomeWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    return BlocBuilder<UserCheckBloc, UserCheckState>(
      builder: (context, state) {
        if (state.status == UserStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.userExists == true) {
          return const BottomNavBar();
        }
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                      controller: usernameController,
                      hint: 'Please enter username',
                    ),
                    AppSpacing.sboxH20,
                    BlocListener<LoginBloc, LoginState>(
                      listenWhen: (previous, current) {
                        return previous.status == LoginStatus.loading &&
                            current.status == LoginStatus.loaded;
                      },
                      listener: (context, state) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const BottomNavBar(),
                          ),
                        );
                      },
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context).add(
                            SaveUserDetailsEvent(
                                username: usernameController.text),
                          );
                        },
                        child: const Text('Continue'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
