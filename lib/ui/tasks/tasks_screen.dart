import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routes/app_pages.dart';

class Tasks extends StatefulWidget {
  const Tasks({Key? key}) : super(key: key);

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(249, 252, 255, 1),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  taskType('Personal', 'assets/images/user.png', 24,
                      const Color.fromRGBO(255, 238, 155, 0.36)),
                  const SizedBox(width: 20),
                  taskType('Work', 'assets/images/work.png', 24,
                      const Color.fromRGBO(181, 255, 155, 0.36)),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  taskType('Meeting', 'assets/images/meeting.png', 23,
                      const Color.fromRGBO(255, 155, 205, 0.36)),
                  const SizedBox(width: 20),
                  taskType('Shopping', 'assets/images/shopping.png', 21,
                      const Color.fromRGBO(255, 208, 155, 0.36)),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  taskType('Party', 'assets/images/party.png', 21,
                      const Color.fromRGBO(155, 255, 248, 0.36)),
                  const SizedBox(width: 20),
                  taskType('Study', 'assets/images/study.png', 21,
                      const Color.fromRGBO(155, 255, 248, 0.36)),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
  }

  Widget taskType(String typeName, String image, int tasksCount, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.taskOpen,
            arguments: typeName.toLowerCase());
      },
      child: Container(
        height: 180,
        width: 160,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(187, 187, 187, 0.35),
                spreadRadius: 4,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
            color: Colors.white),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 65,
                width: 65,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.5), color: color),
                child: Center(
                  child: Image(
                    image: AssetImage(image),
                    height: 33,
                    width: 28,
                  ),
                ),
              ),
              Text(
                typeName,
                style: GoogleFonts.rubik(
                    color: const Color.fromRGBO(104, 104, 104, 1),
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              Text(
                '$tasksCount tasks',
                style: GoogleFonts.rubik(
                    color: const Color.fromRGBO(161, 161, 161, 2),
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }
}
