import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

// InkWell homePageCard(BuildContext context, String name, Widget page) {
//   return InkWell(
//       onTap: () {
//         Navigator.push(
//             context,
//             PageTransition(
//                 type: PageTransitionType.scale,
//                 alignment: Alignment.bottomCenter,
//                 child: page));
//       },
//       child: FadeInUp(
//           duration: const Duration(milliseconds: 1000),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: MediaQuery.of(context).size.width * .45,
//               height: 80,
//               child: Center(
//                 child: Center(
//                     child: Text(
//                   name,
//                   style: tilte1Style,
//                   textAlign: TextAlign.center,
//                 )),
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(12),
//                 shape: BoxShape.rectangle,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade500,
//                     offset: const Offset(4, 7),
//                     blurRadius: 15,
//                     spreadRadius: 1,
//                   ),
//                   const BoxShadow(
//                     color: Colors.white12,
//                     offset: Offset(-7, -4),
//                     blurRadius: 15,
//                     spreadRadius: 1,
//                   ),
//                 ],
//               ),
//             ),
//           )));
// }
InkWell homePageCard(BuildContext context, String name, Widget page) {
  return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                child: page));
      },
      child: FadeInUp(
          duration: const Duration(milliseconds: 1000),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * .45,
              height: 80,
              child: Center(
                child: Center(
                    child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                )),
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.8)),
              ),
            ),
          )));
}
