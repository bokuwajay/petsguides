import 'package:flutter/material.dart';
import 'package:petsguides/features/auth/presentation/widgets/build_text_field.dart';

Container buildSignInSection() {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: Column(
      children: [
        buildTextField(Icons.mail_lock_outlined, "email address", false, true),
        buildTextField(Icons.lock_outline, "************", true, false),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Checkbox(
                //   // value: isRememberMe,
                //   activeColor: Colors.amber,
                //   onChanged: (value) {
                //     setState(() {
                //       isRememberMe = !isRememberMe;
                //     });
                //   },
                // ),
                const Text("Remember me")
              ],
            ),
            const Text(
              "Forget Password?",
              style: TextStyle(fontSize: 12, color: Colors.black),
            )
          ],
        ),
      ],
    ),
  );
}
