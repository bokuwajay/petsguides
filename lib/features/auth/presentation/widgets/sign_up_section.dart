import 'package:flutter/material.dart';
import 'package:petsguides/core/util/validator.dart';
import 'package:petsguides/features/auth/presentation/widgets/build_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/pets_guides_localizations.dart';

// Container buildSignUpSection() {
//   return Container(
//     margin: const EdgeInsets.only(top: 20),
//     child: Column(
//       children: [
//         // buildTextField(Icons.account_box_outlined, "User Name", false, false),
//         // buildTextField(Icons.email_outlined, "email", false, true),
//         // buildTextField(Icons.lock_outline, "password", true, false),
//         Padding(
//           padding: const EdgeInsets.only(top: 10, left: 10),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   // setState(() {
//                   //   isMale = true;
//                   // });
//                 },
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 30,
//                       height: 30,
//                       margin: const EdgeInsets.only(right: 8),
//                       decoration: BoxDecoration(
//                         // color: isMale ? Colors.amber : Colors.transparent,
//                         border: Border.all(width: 1
//                             // color: isMale ? Colors.transparent : Colors.amber,
//                             ),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: const Icon(Icons.account_circle_outlined),
//                     ),
//                     const Text(
//                       "Male",
//                       style: TextStyle(color: Colors.black12),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 30,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // setState(() {
//                   //   isMale = false;
//                   // });
//                 },
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 30,
//                       height: 30,
//                       margin: const EdgeInsets.only(right: 8),
//                       decoration: BoxDecoration(
//                         // color: isMale ? Colors.transparent : Colors.black,
//                         border: Border.all(
//                           width: 1,
//                           // color: isMale ? Colors.grey : Colors.transparent,
//                         ),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: const Icon(Icons.account_circle_outlined
//                           // color: isMale ? Colors.black : Colors.white,
//                           ),
//                     ),
//                     const Text(
//                       "Female",
//                       style: TextStyle(color: Colors.black12),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//         Container(
//           width: 250,
//           margin: const EdgeInsets.only(top: 20),
//           child: RichText(
//               textAlign: TextAlign.center,
//               text: const TextSpan(
//                   text: "By pressing 'submit' you aggree to our ",
//                   style: TextStyle(color: Colors.black),
//                   children: [
//                     TextSpan(
//                         text: "terms & conditions",
//                         style: TextStyle(color: Colors.orange)),
//                   ])),
//         )
//       ],
//     ),
//   );
// }

class SignUpSection extends StatefulWidget {
  const SignUpSection({super.key});

  @override
  State<SignUpSection> createState() => _SignUpSectionState();
}

class _SignUpSectionState extends State<SignUpSection> with Validator {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  late final TextEditingController _phone;

  @override
  void initState() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _phone = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              buildTextFormField(
                controller: _firstName,
                hintText: "First Name",
                validator: (value) =>
                    validateRequiredField(value, "First Name"),
              ),
              buildTextFormField(
                controller: _lastName,
                hintText: "Last Name",
                validator: (value) => validateRequiredField(value, "Last Name"),
              ),
              buildTextFormField(
                controller: _email,
                hintText: AppLocalizations.of(context)!.email,
                validator: (value) =>
                    validateEmail(value, AppLocalizations.of(context)!.email),
              ),
              buildTextFormField(
                controller: _password,
                hintText: AppLocalizations.of(context)!.password,
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
                validator: (value) => validateRequiredField(
                    value, AppLocalizations.of(context)!.password),
              ),
              buildTextFormField(
                controller: _confirmPassword,
                hintText: "Repeat password",
                prefixIcon: const Icon(Icons.lock),
                obscureText: true,
                validator: (value) => validateConfirmPassword(
                    value, _password as String, "Repeat password"),
              ),
              buildTextFormField(
                controller: _phone,
                hintText: "Phone",
                validator: (value) => validatePhone(value, "Phone"),
              )
            ],
          )),
    );
  }
}
