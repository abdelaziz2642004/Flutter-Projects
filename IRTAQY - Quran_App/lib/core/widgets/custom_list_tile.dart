import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran_app/core/widgets/theme_provider.dart';

import '../../features/home/view_model/home_view_model.dart';
import 'colors.dart';

class CustomListTile extends ConsumerStatefulWidget {
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Widget? leading;

  const CustomListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
    this.leading,
  });

  @override
  ConsumerState<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends ConsumerState<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    ref.watch(favoriteRecitersProvider);
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: isDarkMode ? CustomColors.darkCard : CustomColors.lightCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashFactory: InkRipple.splashFactory,
          onTap: widget.onTap,
          child: ListTile(
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                color:
                    isDarkMode ? CustomColors.darkText : CustomColors.lightText,
              ),
            ),
            subtitle: Text(
              widget.subtitle,
              style: TextStyle(
                color:
                    isDarkMode
                        ? CustomColors.darkSecondaryText
                        : CustomColors.lightSecondaryText,
              ),
            ),
            trailing: widget.trailing,
            iconColor: const Color(0xfff9f6e4),
            leading: widget.leading,
          ),
        ),
      ),
    );
  }
}
