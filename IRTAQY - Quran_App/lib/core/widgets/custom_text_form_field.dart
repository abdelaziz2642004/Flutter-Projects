import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/widgets/theme_provider.dart';

import 'colors.dart';

class CustomTextFormFild extends ConsumerWidget {
  const CustomTextFormFild({
    super.key,
    required this.hint,
    required this.suffixIcon,
    required this.onTapSuffixIcon,
    required this.onChanged,
    required this.prefixIcon,
    required this.filled,
  });

  final String hint;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onTapSuffixIcon;
  final bool filled;

  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        initialValue: "",
        onChanged: onChanged,
        keyboardType: TextInputType.emailAddress,
        cursorColor: isDark ? CustomColors.darkText : CustomColors.lightText,

        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: isDark ? CustomColors.darkText : CustomColors.lightText,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: isDark ? CustomColors.darkText : CustomColors.lightText,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(
              color: isDark ? CustomColors.darkText : CustomColors.lightText,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Colors.red),
          ),
          fillColor:
              isDark
                  ? CustomColors.darkBackground
                  : CustomColors.lightBackground,
          iconColor: isDark ? CustomColors.darkText : CustomColors.lightText,
          focusColor: isDark ? CustomColors.darkText : CustomColors.lightText,
          prefixIconColor:
              isDark ? CustomColors.darkText : CustomColors.lightText,

          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: "Inter",
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isDark ? CustomColors.darkText : CustomColors.lightText,
          ),
          prefixIcon: Icon(prefixIcon, size: 20),
          suffixIcon: IconButton(
            icon: Icon(suffixIcon, size: 20),
            onPressed: onTapSuffixIcon,
          ),
          filled: filled,
        ),
      ),
    );
  }
}
