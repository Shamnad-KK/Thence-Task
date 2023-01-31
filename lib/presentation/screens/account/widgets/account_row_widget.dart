import 'package:flutter/material.dart';
import 'package:thence_task/core/app_spacing.dart';

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
