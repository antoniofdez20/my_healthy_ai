import 'package:flutter/material.dart';
import 'package:my_healthy_ai/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.hintTextCustom, required this.controller});
  final String hintTextCustom;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: true,
      keyboardType: TextInputType.text,
      cursorColor: MyColors.prussianBlue,
      style: const TextStyle(color: MyColors.prussianBlue),
      decoration: InputDecoration(
        hintText: hintTextCustom,
        hintStyle: const TextStyle(color: MyColors.prussianBlue),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.prussianBlue,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(26)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: MyColors.prussianBlue,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(26)),
        ),
      ),
      controller: controller,
    );
  }
}
