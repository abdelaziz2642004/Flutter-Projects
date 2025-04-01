import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String type;

  const SignButton({
    required this.isLoading,
    required this.onPressed,
    required this.type,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        backgroundColor: const Color(0xffc47c51),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child:
          isLoading
              ? const CircularProgressIndicator()
              : Text(
                'Sign $type',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: "DopisBold",
                ),
              ),
    );
  }
}
