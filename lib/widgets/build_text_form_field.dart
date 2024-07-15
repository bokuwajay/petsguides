import 'package:flutter/material.dart';

class buildTextFormField extends StatefulWidget {
  const buildTextFormField({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.hintText,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.contentPadding,
    this.onChanged,
    this.enable = true,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hintText;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onChanged;
  final bool enable;

  @override
  State<buildTextFormField> createState() => _buildTextFormFieldState();
}

class _buildTextFormFieldState extends State<buildTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        contentPadding: widget.contentPadding,
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0, end: 10.0),
          child: widget.suffixIcon,
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 16, minHeight: 16),
      ),
      validator: widget.validator,
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      enabled: widget.enable,
    );
  }
}
