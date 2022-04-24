import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import '../../database/boxes.dart';
import '../../models/task.dart';
import '../main/empty.dart';

class TaskOpen extends StatefulWidget {
  const TaskOpen({Key? key}) : super(key: key);

  @override
  State<TaskOpen> createState() => _TaskOpenState();
}

class _TaskOpenState extends State<TaskOpen> {
  @override
  Widget build(BuildContext context) {
    final String taskType =
        ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(238),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            height: 107,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  Color.fromRGBO(56, 103, 213, 1),
                  Color.fromRGBO(129, 199, 245, 1),
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 55),
                Text(
                  ' Hello Brenda!',
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  ' This is your ${taskType}s tasks',
                  style: GoogleFonts.rubik(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )),
      body: ValueListenableBuilder<Box<Task>>(
        valueListenable: Boxes.getTasks().listenable(),
        builder: (context, box, _) {
          final tasks = box.values.toList().cast<Task>();

          final List<Task> list = [];

          for (var i = 0; i < tasks.length; i++) {
            if (tasks[i].status == taskType) {
              list.add(tasks[i]);
            }
          }

          return buildTasks(list);
        },
      ),
    );
  }

  Widget buildTasks(List<Task> listTask) {
    if (listTask.isEmpty) {
      return const Empty();
    } else {
      return SizedBox(
        height: listTask.length * 75,
        child: ListView.builder(
            padding: const EdgeInsets.all(16),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listTask.length,
            itemBuilder: (BuildContext context, int index) =>
                task(listTask[index])),
      );
    }
  }

  Widget task(Task task) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(
                0,
                3,
              ), // changes position of shadow
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 36,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.05),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(
                          0,
                          3,
                        ), // changes position of shadow
                      ),
                    ],
                    color: const Color.fromRGBO(255, 255, 255, 1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 55,
                            width: 4,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5)),
                                color: task.status == 'personal'
                                    ? const Color.fromRGBO(255, 213, 6, 1)
                                    : task.status == 'work'
                                        ? const Color.fromRGBO(30, 209, 2, 1)
                                        : task.status == 'meeting'
                                            ? const Color.fromRGBO(
                                                209, 2, 99, 1)
                                            : task.status == 'study'
                                                ? const Color.fromRGBO(
                                                    48, 68, 242, 1)
                                                : task.status == 'shopping'
                                                    ? const Color.fromRGBO(
                                                        242, 145, 48, 1)
                                                    : Colors.transparent),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 11),
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9),
                                border:
                                    Border.all(width: 2, color: Colors.grey)),
                          ),
                          Text(
                            '${task.hour.toString().padLeft(2, '0')}:${task.minute.toString().padLeft(2, '0')}',
                            style: GoogleFonts.rubik(
                                color: const Color.fromRGBO(198, 198, 200, 1),
                                fontSize: 11,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 17),
                          Text(
                            task.taskName,
                            style: GoogleFonts.rubik(
                                color: const Color.fromRGBO(85, 78, 143, 1.0),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const Image(
                      image: AssetImage(
                        'assets/images/bell_.png',
                      ),
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              SizedBox(
                width: 85,
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(17.5)),
                            color: Color.fromRGBO(196, 206, 245, 1)),
                        child: Center(
                          child: Image.asset(
                            'assets/images/comment.png',
                            height: 16,
                            width: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        task.delete();
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(17.5)),
                            color: Color.fromRGBO(255, 207, 207, 1)),
                        child: Center(
                          child: Image.asset(
                            'assets/images/trash.png',
                            height: 16,
                            width: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
