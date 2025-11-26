import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({super.key, required this.options, this.onChanged, required this.label, required this.selectedValue});

  final String selectedValue;
  final String label;
  final List<String> options;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        items:
            options.map((option) {
              return DropdownMenuItem(value: option, child: Text(option));
            }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          label: Text(label),
        ),
      ),
    );
  }
}
