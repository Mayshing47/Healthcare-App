import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.isPasswordField,
    required this.obscureText,
    this.togglePasswordState,
  });

  final String labelText;
  final TextEditingController controller;
  final bool isPasswordField;
  final bool obscureText;
  final void Function()? togglePasswordState;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        hintText: labelText,
        prefixIcon: _buildPrefixIcon(),
        suffixIcon: _buildSuffixIcon(),
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

  Widget _buildPrefixIcon() {
    return isPasswordField ? Icon(Icons.lock) : Icon(Icons.person);
  }

  Widget? _buildSuffixIcon() {
    return isPasswordField
        ? IconButton(
          onPressed: togglePasswordState,
          icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
        )
        : null;
  }
}
