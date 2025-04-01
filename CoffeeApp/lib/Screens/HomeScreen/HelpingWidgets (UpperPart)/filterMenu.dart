import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prj/Models/Coffee.dart';
import 'package:prj/Screens/HomeScreen/HelpingWidgets%20(UpperPart)/FilterFunctions.dart';

const Color kPrimaryColor = Color(0xFFC47C51);
const Color kButtonColor = Color.fromARGB(255, 196, 124, 72);
const Color kActiveSwitchColor = Color.fromARGB(255, 175, 75, 17);
const double kButtonSize = 55;
const double kIconSize = 28;
const double kBorderRadius = 14;

class FilterMenu extends StatefulWidget {
  const FilterMenu({super.key, required this.fromOut, required this.filtering});

  final bool fromOut;
  final Function(Map<filters, bool>) filtering;

  @override
  State<FilterMenu> createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  FiltersUI filtersUI = FiltersUI();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kButtonSize,
      width: kButtonSize,
      decoration: BoxDecoration(
        color: kButtonColor,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/tune.svg',
          width: kIconSize,
          height: kIconSize,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        onPressed: () {
          filtersUI.showFilterDialog(context, widget.fromOut, widget.filtering);
        },
      ),
    );
  }
}
