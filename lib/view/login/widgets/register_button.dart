import 'package:flutter/material.dart';
import 'package:vita_client_app/util/constant/font.dart';
import 'package:vita_client_app/util/constant/routes.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, Routes.register);
      },
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(45),
          padding: const EdgeInsets.all(12)),
      child: const Text(
        "Register",
        style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: poppins,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
