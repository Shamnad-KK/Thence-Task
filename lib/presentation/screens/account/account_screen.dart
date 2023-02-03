import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence_task/core/app_spacing.dart';
import 'package:thence_task/presentation/blocs/auth/auth_bloc.dart';
import 'package:thence_task/presentation/screens/account/widgets/account_row_widget.dart';
import 'package:thence_task/presentation/screens/address/address_screen.dart';
import 'package:thence_task/presentation/screens/auth/login_screen.dart';
import 'package:thence_task/theme/app_textstyle.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1),
            Text('Username', style: AppTextStyle.title1),
            AppSpacing.sboxH10,
            Text('+91 1234567890', style: AppTextStyle.body2),
            AppSpacing.sboxH30,
            AccountRowWidget(
              text: 'Edit Profile',
              icon: Icons.person_outline,
              onTap: () {},
            ),
            AccountRowWidget(
              text: 'Address',
              icon: Icons.location_on,
              onTap: () {
                _gotoAddressScreen(context);
              },
            ),
            AccountRowWidget(
              icon: Icons.privacy_tip_outlined,
              text: "Privacy Policy",
              onTap: () {},
            ),
            AccountRowWidget(
              icon: Icons.help_center_outlined,
              text: "Help Center",
              onTap: () {},
            ),
            AccountRowWidget(
              icon: CupertinoIcons.person_2,
              text: "Invite Friends",
              onTap: () {},
            ),
            BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Unauthenticated) {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false);
                }
              },
              child: AccountRowWidget(
                icon: Icons.logout,
                text: "Log out",
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _gotoAddressScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const Addressscreen(),
      ),
    );
  }
}
