import 'package:flutter/material.dart';
import 'package:vita_client_app/util/constant/font.dart';

class LoginButton extends StatelessWidget {
  final void Function() onPressed;

  const LoginButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(45),
          padding: const EdgeInsets.all(12)),
      child: const Text(
        "Login",
        style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: poppins,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
