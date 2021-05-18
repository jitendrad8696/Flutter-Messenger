import 'package:flutter/material.dart';

class ReusableTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget suffixIcon;
  final FocusNode focusNode;
  final IconData iconData;
  ReusableTextFormField({
    @required this.hintText,
    @required this.iconData,
    @required this.controller,
    @required this.focusNode,
    @required this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      textAlign: TextAlign.start,
      controller: controller,
      style: TextStyle(),
      onChanged: (value) {},
      autofocus: false,
      decoration: InputDecoration(
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: Icon(
          iconData,
          color: Colors.grey,
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
