// import 'package:store_app/FieldsData/abstract_validate.dart';
import 'FieldsData/abstract_validate.dart';
import 'package:flutter/material.dart';

class LoginAndSignupField extends StatefulWidget {
  const LoginAndSignupField({super.key, required this.field});

  final Field field;

  @override
  State<LoginAndSignupField> createState() => _LoginAndSignupFieldState();
}

class _LoginAndSignupFieldState extends State<LoginAndSignupField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.field.validator,
      onChanged: widget.field.onChanged,
      decoration: InputDecoration(
        // Label inside the input field
        labelText:
            widget
                .field
                .text, // "text" Appears inside the input field and moves up when text is entered.
        // Adds a border around the field with rounded corners
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            15,
          ), // Creates rounded edges (12px)
        ),

        // Suffix Icon
        suffixIcon: IconButton(icon: Icon(widget.field.icon), onPressed: () {}),
      ),
    );
  }
}
