import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String inputLabel;
  final String? hintText;
  final IconData? icon;
  final bool isPassword;
  final bool isEnabled;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.inputLabel,
    this.hintText,
    this.icon,
    this.isPassword = false,
    this.isEnabled = true,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (inputLabel.isNotEmpty)
          Text(
            inputLabel,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          enabled: isEnabled,
          obscureText: isPassword,
          keyboardType: keyboardType,
          maxLength: maxLength,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: icon != null ? Icon(icon) : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            counterText: "",
          ),
        ),
      ],
    );
  }
}
