import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.black54,
        ),
        filled: true,
        fillColor: Colors.grey[200],
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black54,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
