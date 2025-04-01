import 'package:flutter/material.dart';

class LocationDropdown extends StatelessWidget {
  const LocationDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Location", style: TextStyle(color: Colors.grey)),
        SizedBox(
          width: 150,
          height: 30,
          child: DropdownButton<String>(
            value: "Bilzen, Tanjungbalai",
            style: const TextStyle(fontSize: 14, color: Color(0xFFd4d4d4)),
            items: const [
              DropdownMenuItem(
                value: "Bilzen, Tanjungbalai",
                child: Text(
                  "Bilzen, Tanjungbalai",
                  style: TextStyle(fontSize: 14, color: Color(0xFFd4d4d4)),
                ),
              ),
            ],
            onChanged: (val) {},
            underline: const SizedBox(), // Removes default underline
          ),
        ),
      ],
    );
  }
}
