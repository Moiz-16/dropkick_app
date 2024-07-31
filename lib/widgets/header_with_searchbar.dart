import 'package:dropkick_app/data/constants.dart';
import 'package:flutter/material.dart';

class HeaderWithSearchbox extends StatelessWidget {
  const HeaderWithSearchbox({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
      ),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: kDefaultSize),
        height: 40,
        decoration: BoxDecoration(
          color: Color(0xFF6632F5).withOpacity(0.1),
          borderRadius: BorderRadius.circular(27),
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(0, 10),
          //     blurRadius: 20,
          //     color: kPrimaryColour.withOpacity(0.1),
          //   ),
          // ],
        ),
        // search bar contents
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                cursorColor: kSecondaryColour,
                decoration: InputDecoration(
                  icon: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Icon(
                      Icons.search,
                      color: kPrimaryColour,
                      // add custom icons also
                    ),
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: kPrimaryColour,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hoverColor: kPrimaryColour,
                ),
              ),
            ),
            // SVG picture code
          ],
        ),
      ),
    );
  }
}





// class HeaderWithSearchbox extends StatelessWidget {
//   const HeaderWithSearchbox({
//     Key? key,
//     required this.size,
//   }) : super(key: key);

//   final Size size;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Color(0xFF0E3311).withOpacity(0),
//       height: size.height * 0.075,
//       child: Stack(
//         children: <Widget>[
//           Container(
//             //purple extended box
//             height: size.height * 0.075 - 20,
//             decoration: BoxDecoration(
//               color: Colors.amber,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//             ),
//           ),
//           // // search bar creation?
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               alignment: Alignment.center,
//               margin: EdgeInsets.symmetric(horizontal: kDefaultSize) / 1.5,
//               padding: EdgeInsets.symmetric(horizontal: kDefaultSize),
//               height: 54,
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     offset: Offset(0, 10),
//                     blurRadius: 20,
//                     color: kPrimaryColour.withOpacity(0.1),
//                   ),
//                 ],
//               ),
//               // search bar contents
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       cursorColor: kSecondaryColour,
//                       decoration: InputDecoration(
//                         hintText: "Search",
//                         hintStyle: TextStyle(
//                           color: kPrimaryColour.withOpacity(0.5),
//                         ),
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   // SVG picture code
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
