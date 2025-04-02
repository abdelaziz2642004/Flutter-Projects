import 'package:flutter/material.dart';

class Custom_option extends StatelessWidget {
  final Widget child;
  final String title;
  final Widget destination;
  const Custom_option({
    super.key, required this.child, required this.title,required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => destination));
            },
            child: Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: child,
            ),
          ),
          Text(title),
        ]
    );
  }
}