import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 180),
            const Image(
                height: 195,
                width: 179,
                image: AssetImage('assets/images/logo.png')),
            const SizedBox(height: 125),
            Text(
              'Reminders made simple',
              style: GoogleFonts.rubik(
                  color: const Color.fromRGBO(85, 78, 143, 1),
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 160),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.main);
              },
              child: Container(
                width: 258,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Color.fromRGBO(57, 168, 1, 1),
                          Color.fromRGBO(93, 230, 26, 1),
                        ])),
                child: Center(
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
