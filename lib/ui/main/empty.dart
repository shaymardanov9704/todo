import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            height: 165,
            width: 120,
            image: AssetImage('assets/images/task_empty.png'),
          ),
          const SizedBox(height: 50),
          Text(
            'No tasks',
            style: GoogleFonts.rubik(
                color: const Color.fromRGBO(85, 78, 143, 1),
                fontSize: 22,
                fontWeight: FontWeight.w500),
          )
        ],
      )),
    );
  }
}
