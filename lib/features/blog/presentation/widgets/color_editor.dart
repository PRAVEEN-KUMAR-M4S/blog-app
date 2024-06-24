
import 'package:flutter/material.dart';



class ColorEditor extends StatelessWidget {
  final String text;
  final VoidCallback ontap;
  final Color selectedColor;
  const ColorEditor({
    super.key,
    required this.text,
    required this.ontap, required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: ontap,
      readOnly: true,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
          hintText: text,
          fillColor: selectedColor,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15))),
    );
  }
}
