import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String inputLabel;
  final String? hintText;
  final IconData? icon;
  final bool isPassword;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;
  final Widget? suffixWidget;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;

  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.inputLabel,
    this.hintText,
    this.icon,
    this.isPassword = false,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
    this.suffixWidget,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      readOnly: readOnly,
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
        if (inputFormatters != null) ...inputFormatters!,
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
