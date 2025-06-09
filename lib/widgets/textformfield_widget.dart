import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final Widget? suffixWidget;

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
    this.suffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: isEnabled,
      obscureText: isPassword,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLines: maxLines,
      validator: validator,
      inputFormatters: [
        TextInputFormatter.withFunction(
          (oldValue, newValue) => newValue.copyWith(
            text: newValue.text.toUpperCase(),
            selection: newValue.selection,
          ),
        ),
      ],
      decoration: InputDecoration(
        label: Text(
          inputLabel,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        suffix: suffixWidget,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        counterText: "",
      ),
    );
  }
}
