import 'package:flutter/material.dart';
import 'package:health_care_application/utils/utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.child,
    required this.onTap,
  });

  final Widget child;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: Utils.getScreenWidth(context),
        height: Utils.getScreenHeight(context) * 0.064,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.primary
        ),
        child: child,
      ),
    );
  }
}
