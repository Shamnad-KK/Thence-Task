import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/presentation/blocs/login/login_bloc.dart';
import 'package:thence_task/presentation/screens/auth/otp_screen.dart';
import 'package:thence_task/presentation/screens/auth/widgets/auth_appbar_title_widget.dart';
import 'package:thence_task/presentation/screens/auth/widgets/auth_title_widget.dart';
import 'package:thence_task/presentation/widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController mobileController = TextEditingController();

    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AuthAppbarTitleWidget(title: 'Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const AuthTitleWidget(title: 'Enter your mobile number'),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 10,
              ),
              child: CustomTextField(
                controller: mobileController,
                hint: '',
                keyboardType: TextInputType.phone,
              ),
            ),
            BlocListener<LoginBloc, LoginState>(
              listenWhen: (previous, current) {
                return previous.verId == '' && current.verId != '';
              },
              listener: (context, state) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OtpScreen(),
                  ),
                );
                loginBloc.add(ChangeRemainingTimeEvent());
              },
              child: ElevatedButton(
                onPressed: () {
                  loginBloc.add(
                    LoginEvent(mobile: "+91${mobileController.text}"),
                  );
                },
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
