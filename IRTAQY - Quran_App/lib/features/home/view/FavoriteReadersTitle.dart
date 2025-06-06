import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/widgets/colors.dart';
import 'package:quran_app/core/widgets/theme_provider.dart';

class FavoriteReadersTitle extends ConsumerStatefulWidget {
  final VoidCallback? onTap;

  const FavoriteReadersTitle({super.key, this.onTap});

  @override
  ConsumerState<FavoriteReadersTitle> createState() =>
      _FavoriteReadersTitleState();
}

class _FavoriteReadersTitleState extends ConsumerState<FavoriteReadersTitle> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    final textColor =
        isDarkMode ? CustomColors.darkText : CustomColors.lightText;

    return GestureDetector(
      onTap: widget.onTap,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow:
                  _isHovered
                      ? [
                        const BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ]
                      : [],
            ),
            child: Text(
              'Favorite Readers',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
