import 'package:flutter/material.dart';

// Widget buildTextField(
//     IconData icon, String hintText, bool isPassword, bool isEmail) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 8.0),
//     child: TextField(
//       obscureText: isPassword,
//       keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
//       decoration: InputDecoration(
//           prefixIcon: Icon(
//             icon,
//             color: Colors.grey,
//           ),
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey),
//             borderRadius: BorderRadius.all(
//               Radius.circular(35.0),
//             ),
//           ),
//           focusedBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.red),
//             borderRadius: BorderRadius.all(
//               Radius.circular(35.0),
//             ),
//           ),
//           contentPadding: const EdgeInsets.all(10),
//           hintText: hintText,
//           hintStyle: const TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//           )),
//     ),
//   );
// }

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
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hintText;
  final Widget? prefixIcon;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  State<buildTextFormField> createState() => _buildTextFormFieldState();
}

class _buildTextFormFieldState extends State<buildTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
        ),
        validator: widget.validator,
        obscureText: widget.obscureText,
      ),
    );
  }
}
