import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thence_task/core/app_spacing.dart';
import 'package:thence_task/presentation/screens/address/address_screen.dart';
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

class AccountRowWidget extends StatelessWidget {
  const AccountRowWidget({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            AppSpacing.sboxW10,
            Text(text),
            const Spacer(),
            const Icon(
              Icons.arrow_forward,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
