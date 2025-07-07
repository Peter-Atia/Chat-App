import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({super.key, this.hintText, this.onChanged});
  final String? hintText;
  Function(String)? onChanged;
  bool obscureTextCheck = false;
  @override
  Widget build(context) {
    if (hintText == "Password") {
      obscureTextCheck = true;
    }
    return TextFormField(
      obscureText: obscureTextCheck,
      validator: (data) {
        if (data!.isEmpty) {
          return "Required Field";
        }
        if (hintText == "Email") {
          if (!({data[0]} != "@" &&
              data.contains("@") &&
              data.contains(".com"))) {
            return "Invalid Email.";
          }
        }
        if (hintText == "Password") {
          if (data.length < 6) {
            return "Invalid password.";
          }
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
