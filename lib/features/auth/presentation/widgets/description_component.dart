import 'package:flutter/material.dart';

class DescriptionComponent extends StatelessWidget {
  const DescriptionComponent({super.key, required this.descriptionText});

  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Text(descriptionText, style: Theme.of(context).textTheme.bodyLarge!.copyWith(
      fontWeight: FontWeight.w900,
    ),);
  }
}
