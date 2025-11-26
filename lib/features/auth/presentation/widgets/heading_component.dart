import 'package:flutter/material.dart';

class HeadingComponent extends StatelessWidget {
  const HeadingComponent({super.key, required this.headingText});

  final String headingText;

  @override
  Widget build(BuildContext context) {
    return Text(headingText, style: Theme.of(context).textTheme.displayMedium!.copyWith(
      fontWeight: FontWeight.w900,
    ),);
  }
}
