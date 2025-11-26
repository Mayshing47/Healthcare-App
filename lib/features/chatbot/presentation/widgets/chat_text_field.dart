import 'package:flutter/material.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    super.key,
    required this.labelText,
    required this.controller,
  });

  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: false,
      controller: controller,
      decoration: InputDecoration(
        hintText: labelText,
        border: _buildBorder(),
        enabledBorder: _buildBorder(),
        focusedBorder: _buildBorder(),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(10));
  }

}
