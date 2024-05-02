import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    this.controller,
    this.fillColor = Colors.white,
    this.validator,
    this.obscureText = false,
    this.onChanged,
    this.keyboardType,
    this.suffixIcon,
    this.hintText,
    this.prefixIcon,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.isDropDown = false,
  }) : super(key: key);

  final TextEditingController? controller;
  final Color? fillColor;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final int maxLines;
  final TextAlign textAlign;
  final bool isDropDown;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: !isDropDown,
      onChanged: onChanged,
      maxLines: maxLines,
      obscureText: obscureText,
      validator: validator != null
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              if (validator!(value) != null) {
                return validator!(value)!;
              }
              return null;
            }
          : null,
      controller: controller,
      cursorColor: Colors.black,
      // style: Theme.of(context).textTheme.bodyText2?.copyWith(
      //   color: Colors.grey,
      // ),
      textAlign: textAlign,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.grey,
        suffixIconColor: Colors.grey,
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
        contentPadding: const EdgeInsets.only(
          left: 16,
          top: 11,
          bottom: 11,
          right: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(.5),
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Colors.red.withOpacity(.3),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
