import 'package:flutter/material.dart';

class add extends StatefulWidget {
  const add({super.key});
  @override
  _addstate createState() => _addstate();
}

class _addstate extends State<add> {
  var _isUnderstood = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              _isUnderstood = false;
            });
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _isUnderstood = true;
            });
          },
          child: const Text('Yes'),
        ),
        const SizedBox(height: 10),
        if (_isUnderstood) const Text('Awesome!')
      ],
    );
  }
}
