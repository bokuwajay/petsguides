import 'package:flutter/material.dart';
import 'package:petsguides/features/auth/presentation/widgets/build_text_field.dart';

Container buildSignUpSection() {
  return Container(
    margin: const EdgeInsets.only(top: 20),
    child: Column(
      children: [
        buildTextField(Icons.account_box_outlined, "User Name", false, false),
        buildTextField(Icons.email_outlined, "email", false, true),
        buildTextField(Icons.lock_outline, "password", true, false),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   isMale = true;
                  // });
                },
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        // color: isMale ? Colors.amber : Colors.transparent,
                        border: Border.all(width: 1
                            // color: isMale ? Colors.transparent : Colors.amber,
                            ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.account_circle_outlined),
                    ),
                    const Text(
                      "Male",
                      style: TextStyle(color: Colors.black12),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              GestureDetector(
                onTap: () {
                  // setState(() {
                  //   isMale = false;
                  // });
                },
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        // color: isMale ? Colors.transparent : Colors.black,
                        border: Border.all(
                          width: 1,
                          // color: isMale ? Colors.grey : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Icons.account_circle_outlined
                          // color: isMale ? Colors.black : Colors.white,
                          ),
                    ),
                    const Text(
                      "Female",
                      style: TextStyle(color: Colors.black12),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          width: 250,
          margin: const EdgeInsets.only(top: 20),
          child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                  text: "By pressing 'submit' you aggree to our ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: "terms & conditions",
                        style: TextStyle(color: Colors.orange)),
                  ])),
        )
      ],
    ),
  );
}
