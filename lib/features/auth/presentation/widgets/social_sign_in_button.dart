import 'package:flutter/material.dart';

class SocialSignInButton extends StatelessWidget {
  const SocialSignInButton({
    super.key,
    required this.logoUrl,
    required this.label,
    required this.isGoogleSignInButton,
    required this.onTap,
  });

  final String logoUrl;
  final String label;
  final bool isGoogleSignInButton;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 10
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isGoogleSignInButton ? Colors.white : Colors.black
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(logoUrl, width: 20, height: 20,),
              SizedBox(width: 10,),
              Text(label, style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: isGoogleSignInButton ? Colors.black : Colors.white,
                fontWeight: FontWeight.w900,
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
