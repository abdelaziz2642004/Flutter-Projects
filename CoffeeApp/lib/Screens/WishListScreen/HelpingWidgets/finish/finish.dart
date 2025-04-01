import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prj/Models/User.dart';
import 'package:prj/Providers/userProvider.dart';

Widget finish(void Function()? checkout, WidgetRef ref) {
  user currentUser = ref.read(userProvider).value ?? user();

  double total = currentUser.wishlist.total;
  double taxes = currentUser.wishlist.total * 14 / 100;

  return ClipRRect(
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(20),
    ),

    child: Container(
      height: 160,
      width: double.infinity,
      color: const Color.fromARGB(255, 209, 209, 209),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Price without Taxes : \$ ${total.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.normal,
                      fontFamily: 'DopisBold',
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Taxes(14%): \$ ${taxes.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.normal,
                      fontFamily: 'DopisBold',
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Ensures vertical alignment
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Align text vertically
                    children: [
                      const Text(
                        "Total Price:",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'DopisBold',
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        "\$ ${(total + taxes).toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Color(0xffc47c51),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'DopisBold',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: checkout,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 17,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: const Color(0xffc47c51),
                      ),
                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.normal,
                          fontFamily: 'DopisBold',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
