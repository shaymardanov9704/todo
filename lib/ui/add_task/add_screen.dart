import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../database/boxes.dart';
import '../../models/task.dart';

class AddScreen extends StatefulWidget {
  final Task? task;

  const AddScreen({Key? key, this.task}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final taskNameController = TextEditingController();

  String status = 'isEmpty';

  DateTime date = DateTime.now();

  TimeOfDay time = TimeOfDay.now();

  int hour = 0;
  int minute = 0;

  String timeOfDay = '';

  Future pickDate() async {
    final initialDateTime = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDateTime,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 5));
    if (newDate == null) return;
    setState(() => {
          date = newDate,
        });
  }

  Future pickTime() async {
    final initialDateTime = TimeOfDay(hour: 9, minute: 0);
    final newDateTime =
        await showTimePicker(context: context, initialTime: initialDateTime);
    if (newDateTime == null) return;
    setState(() => {
          time = newDateTime,
          hour = newDateTime.hour,
          minute = newDateTime.minute
        });
  }

  String getTime() {
    if (time == null) {
      return '';
    } else {
      final hours = time.hour.toString().padLeft(2, '0');
      final minute = time.minute.toString().padLeft(2, '0');
      timeOfDay = '$hours:$minute';
      return timeOfDay;
    }
  }

  String getDate() {
    if (date == null) {
      return '';
    } else {
      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      return '$day/$month/${date.year}';
    }
  }

  showError(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Task details not \nincluded in full !!! \n\nPlease enter the tasks \ndetails in full",
            style: GoogleFonts.roboto(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        );
      },
    );
  }

  Future addTask(String name, String status, DateTime dateTime, int hour,
      int minute) async {
    final task = Task()
      ..taskName = name
      ..status = status
      ..dateTime = dateTime
      ..hour = hour
      ..minute = minute;

    final box = Boxes.getTasks();
    box.add(task);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Task? task = widget.task;
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
                    ' Hello Eldor!',
                    style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    ' Add task for your Performance',
                    style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(26),
              height: 700,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Add a New Task',
                      style: GoogleFonts.rubik(
                          color: const Color.fromRGBO(64, 64, 64, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: taskNameController,
                    style: GoogleFonts.rubik(
                        color: const Color.fromRGBO(55, 55, 55, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(hintText: 'Title'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //#task_types
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              status = 'personal';
                            });
                          },
                          child: status == 'personal'
                              ? Container(
                                  height: 26,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          const Color.fromRGBO(255, 213, 6, 1)),
                                  child: Center(
                                    child: Text(
                                      ' Personal ',
                                      style: GoogleFonts.rubik(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.yellow),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Personal',
                                      style: GoogleFonts.rubik(
                                          color: const Color.fromRGBO(
                                              142, 142, 142, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              status = 'work';
                            });
                          },
                          child: status == 'work'
                              ? Container(
                                  height: 26,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          const Color.fromRGBO(30, 209, 2, 1)),
                                  child: Center(
                                    child: Text(
                                      ' Work ',
                                      style: GoogleFonts.rubik(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromRGBO(
                                              30, 209, 2, 1)),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Work',
                                      style: GoogleFonts.rubik(
                                          color: const Color.fromRGBO(
                                              142, 142, 142, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              status = 'meeting';
                            });
                          },
                          child: status == 'meeting'
                              ? Container(
                                  height: 26,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          const Color.fromRGBO(209, 2, 99, 1)),
                                  child: Center(
                                    child: Text(
                                      ' Meeting ',
                                      style: GoogleFonts.rubik(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromRGBO(
                                              209, 2, 99, 1)),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Meeting',
                                      style: GoogleFonts.rubik(
                                          color: const Color.fromRGBO(
                                              142, 142, 142, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              status = 'study';
                            });
                          },
                          child: status == 'study'
                              ? Container(
                                  height: 26,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          const Color.fromRGBO(48, 68, 242, 1)),
                                  child: Center(
                                    child: Text(
                                      ' Study ',
                                      style: GoogleFonts.rubik(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromRGBO(
                                              48, 68, 242, 1)),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Study',
                                      style: GoogleFonts.rubik(
                                          color: const Color.fromRGBO(
                                              142, 142, 142, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              status = 'shopping';
                            });
                          },
                          child: status == 'shopping'
                              ? Container(
                                  height: 26,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color.fromRGBO(
                                          242, 145, 48, 1)),
                                  child: Center(
                                    child: Text(
                                      ' Shopping ',
                                      style: GoogleFonts.rubik(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: const Color.fromRGBO(
                                              242, 145, 48, 1)),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Shopping',
                                      style: GoogleFonts.rubik(
                                          color: const Color.fromRGBO(
                                              142, 142, 142, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              status = 'party';
                            });
                          },
                          child: status == 'party'
                              ? Container(
                                  height: 26,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.purpleAccent.shade200),
                                  child: Center(
                                    child: Text(
                                      ' Party ',
                                      style: GoogleFonts.rubik(
                                          color: const Color.fromRGBO(
                                              255, 255, 255, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.purpleAccent.shade200),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Party ',
                                      style: GoogleFonts.rubik(
                                          color: const Color.fromRGBO(
                                              142, 142, 142, 1),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Container(
                    width: MediaQuery.of(context).size.width - 40,
                    height: 1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Text('Choose Date',
                          style: GoogleFonts.rubik(
                              color: const Color.fromRGBO(142, 142, 142, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(width: 40),
                      Text(getDate(),
                          style: GoogleFonts.rubik(
                              color: const Color.fromRGBO(64, 64, 64, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      IconButton(
                        onPressed: () {
                          pickDate();
                        },
                        icon: const Icon(Icons.date_range,
                            color: Color.fromRGBO(142, 142, 142, 1)),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text('Choose Time',
                          style: GoogleFonts.rubik(
                              color: const Color.fromRGBO(142, 142, 142, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(width: 40),
                      Text(getTime(),
                          style: GoogleFonts.rubik(
                              color: const Color.fromRGBO(64, 64, 64, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 45),
                      IconButton(
                        onPressed: () {
                          pickTime();
                        },
                        icon: const Icon(Icons.timelapse,
                            color: Color.fromRGBO(142, 142, 142, 1)),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  GestureDetector(
                    onTap: () async {
                      if (taskNameController.text.toString() == '' ||
                          status == 'isEmpty' ||
                          (timeOfDay == TimeOfDay.now().hour.toString() &&
                              timeOfDay == TimeOfDay.now().minute.toString()) ||
                          date.day < DateTime.now().day) {
                        showError(context);
                      } else {
                        addTask(taskNameController.text.toString(), status,
                            date, hour, minute);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      height: 53,
                      width: 323,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(126, 182, 255, 1),
                                Color.fromRGBO(95, 135, 231, 1),
                              ])),
                      child: Center(
                        child: Text(
                          'Save Task',
                          style: GoogleFonts.rubik(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
