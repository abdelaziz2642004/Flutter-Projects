// import 'package:flutter/material.dart';

// class Summary extends StatelessWidget {
//   const Summary({super.key, required this.qsummary});
//   final List<Map<String, dynamic>> qsummary;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 500,
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: qsummary.map((data) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 0),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     child: Text(
//                       data['i'].toString(),
//                       textAlign: TextAlign
//                           .right, // Align text to the right within this container
//                     ),
//                   ),
//                   const SizedBox(
//                       width:
//                           30), // Adds space between the number and the column
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           data['q'].toString(),
//                           style: const TextStyle(
//                             color: Color.fromARGB(255, 255, 255, 255),
//                           ),
//                           // textAlign: TextAlign.left,
//                         ),
//                         const SizedBox(height: 5),
//                         Text(
//                           data['a'].toString(),
//                           style: const TextStyle(
//                             color: Color.fromARGB(148, 255, 255, 255),
//                           ),
//                         ),
//                         Text(
//                           data['a2'].toString(),
//                           style: const TextStyle(
//                             color: Color.fromARGB(147, 170, 208, 250),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Summary extends StatelessWidget {
  const Summary({super.key, required this.qsummary});
  final List<Map<String, dynamic>> qsummary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: qsummary.map((data) {
            return Row(
              // for each question
              // now create a column and on its left is the number ( left= outside the row as we do here)
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: data['a'] == data['a2']
                      ? const Color.fromARGB(184, 140, 244, 140)
                      : const Color.fromARGB(255, 235, 86, 188),
                  radius: 17,
                  child: Text(
                    data['i'].toString(),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    // this is a column , I want every text to start at its left
                    // so basically at the start of its horizontal axis -> crossAxis for column
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['q'].toString(),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      // const SizedBox(height: 5),
                      Text(
                        data['a'].toString(),
                        style: const TextStyle(
                          color: Color.fromARGB(147, 83, 245, 58),
                        ),
                      ),
                      Text(
                        data['a2'].toString(),
                        style: TextStyle(
                          color: data['a'] != data['a2']
                              ? const Color.fromARGB(235, 224, 78, 78)
                              : const Color.fromARGB(147, 83, 245, 58),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
