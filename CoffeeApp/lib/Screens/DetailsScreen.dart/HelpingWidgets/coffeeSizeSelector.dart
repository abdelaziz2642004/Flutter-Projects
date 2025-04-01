import 'package:flutter/material.dart';

List<Widget> SizeSelector({
  required String selectedSize,
  required void Function(String) chooseSize,
}) {
  return [
    const Text(
      "Size",
      style: TextStyle(
        color: Color(0xff292929),
        fontWeight: FontWeight.bold,
        fontFamily: 'DopisBold',
        fontSize: 18,
      ),
    ),
    const SizedBox(height: 14),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          ['S', 'M', 'L'].map((size) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: GestureDetector(
                onTap: () {
                  chooseSize(size);
                },
                child: Container(
                  height: 43,
                  width: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          selectedSize == size
                              ? const Color(0xffc47c51)
                              : const Color.fromARGB(255, 206, 206, 206),
                      width: 1.0,
                    ),
                    color:
                        selectedSize == size
                            ? const Color(0xfff9f2ed)
                            : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      size,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:
                            selectedSize == size
                                ? const Color(0xffc47c51)
                                : Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 16.5,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    ),
  ];
}
