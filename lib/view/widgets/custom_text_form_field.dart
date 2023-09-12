import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? text;
  final String? hint;
  final bool? obscureText;
  final ValueSetter? onSave;
  final FormFieldValidator? validator;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final Widget? prefixIcon;

  const CustomTextFormField({
    super.key,
    this.text,
    this.hint,
    this.onSave,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.onTap,
    this.prefixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: text,
          fontsize: 14,
          color: Colors.grey.shade900,
        ),
        TextFormField(
          controller: controller,
          onTap: onTap,
          keyboardType: keyboardType,
          obscureText: obscureText!,
          onSaved: onSave,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            fillColor: Colors.white,
          ),
        )
      ],
    );
  }
}
