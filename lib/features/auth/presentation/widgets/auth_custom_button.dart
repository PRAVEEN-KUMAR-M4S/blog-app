import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/theme/app_pallet.dart';

class AuthCustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const AuthCustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
            colors: [AppPallete.gradient1, AppPallete.gradient2],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppPallete.transparentColor,
            foregroundColor: AppPallete.whiteColor,
            fixedSize: const Size(400, 55),
            shadowColor: AppPallete.transparentColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          text,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
