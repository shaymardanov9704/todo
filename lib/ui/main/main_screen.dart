import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_task/routes/app_pages.dart';
import 'package:todo_task/theme/app_colors.dart';
import 'package:todo_task/ui/main/empty.dart';

import '../../database/boxes.dart';
import '../../models/task.dart';
import '../tasks/tasks_screen.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'home_page';

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;
  bool space = true;
  bool home = true;

  Future openBox() async {
    await Hive.openBox<Task>('task');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openBox();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(249, 252, 255, 1),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(238),
          child: ValueListenableBuilder<Box<Task>>(
            valueListenable: Boxes.getTasks().listenable(),
            builder: (context, box, _) {
              final tasks = box.values.toList().cast<Task>();

              final List<Task> todayList = [];
              int hourForRemainder = 0;
              int minuteForRemainder = 0;
              String taskForRemainder = '';
              List<int> hours = [];
              for (var i = 0; i < tasks.length; i++) {
                if (tasks[i].dateTime.day == DateTime.now().day) {
                  todayList.add(tasks[i]);
                }
              }

              for (var j = 0; j < todayList.length; j++) {
                hours.add(todayList[j].hour);
              }

              hours.sort();

              for (var k = 0; k < hours.length; k++) {
                if (hours[k] > TimeOfDay.now().hour) {
                  hourForRemainder = hours[k];
                  taskForRemainder = todayList[k].taskName;
                  minuteForRemainder = todayList[k].minute;
                  break;
                }
              }

              return Container(

                height: space ? 238 : 107,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      Color.fromRGBO(56, 103, 213, 1),
                      Color.fromRGBO(129, 199, 245, 1),
                    ])),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                       alignment: const Alignment(-1,-1),
                            child: Container(
                              width: 120,
                              height: 106,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(100)),
                                color: Color.fromRGBO(255, 255, 255, 0.17)
                              ),
                            )),
                       Column(
                         children: [
                           Align(
                               alignment: const Alignment(-1,-1),
                               child: Container(
                                 width: 80,
                                 height: 80,
                                 decoration: const BoxDecoration(
                                     borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), ),
                                     color: Color.fromRGBO(255, 255, 255, 0.17)
                                 ),
                               )),

                         ],
                       )
                      ],
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child:   Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 55),
                       Row(
                         children: [
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 ' Hello Eldor!',
                                 style: GoogleFonts.rubik(
                                     color: Colors.white,
                                     fontSize: 18,
                                     fontWeight: FontWeight.w400),
                               ),
                               Text(
                                 ' Today you have ${todayList.length} tasks',
                                 style: GoogleFonts.rubik(
                                     color: Colors.white,
                                     fontSize: 18,
                                     fontWeight: FontWeight.w400),
                               ),
                             ],
                           ),
                        const  SizedBox(width: 130,),
                           Container(
                             width: 40,
                             height: 40,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color: Colors.white
                             ),
                           )
                         ],
                       ),
                        const SizedBox(height: 10),
                        space
                            ? Container(
                          padding: const EdgeInsets.only(
                              right: 25, left: 16, top: 10, bottom: 16),
                          margin: const EdgeInsets.only(bottom: 13),
                          height: 106,
                          decoration: BoxDecoration(
                              color:
                              const Color.fromRGBO(255, 255, 255, 0.31),
                              borderRadius: BorderRadius.circular(5)),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Today Reminder',
                                        style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        taskForRemainder,
                                        style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        '${hourForRemainder.toString().padLeft(2, '0')}:${minuteForRemainder.toString().padLeft(2, '0')}',
                                        style: GoogleFonts.rubik(
                                            color: Colors.white,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  const Image(
                                      image: AssetImage(
                                          'assets/images/bell.png')),
                                ],
                              ),
                              Align(
                                alignment: const Alignment(1.2, -1.9),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      space = !space;
                                    });
                                  },
                                  icon: const Icon(CupertinoIcons.clear,
                                      size: 16, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        )
                            : const SizedBox()
                      ],
                    ),
                  )
                  ],
                ),
              );
            },
          )),
      body: home
          ? ValueListenableBuilder<Box<Task>>(
              valueListenable: Boxes.getTasks().listenable(),
              builder: (context, box, _) {
                final tasks = box.values.toList().cast<Task>();

                final List<Task> todayList = [];
                final List<Task> tomorrowList = [];

                for (var i = 0; i < tasks.length; i++) {
                  if (tasks[i].dateTime.day == DateTime.now().day) {
                    todayList.add(tasks[i]);
                  } else {
                    if (tasks[i].dateTime.day == DateTime.now().day + 1) {
                      tomorrowList.add(tasks[i]);
                    }
                  }
                }

                return buildTasks(todayList, tomorrowList);
              },
            )
          : const Tasks(),
      bottomNavigationBar: Container(
        height: 76,
        decoration: const BoxDecoration(
            color: Color.fromRGBO(249, 252, 255, 1),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(187, 187, 187, 0.35),
                spreadRadius: 6,
                blurRadius: 5,
                offset: Offset(
                  0,
                  4,
                ),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  home = true;
                });
              },
              child: SizedBox(
                  height: 50,
                  child: Center(
                    child: Image(
                      height: 38,
                      width: 32,
                      image: AssetImage(home
                          ? 'assets/images/home.png'
                          : 'assets/images/home_d.png'),
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  home = false;
                });
              },
              child: SizedBox(
                  height: 50,
                  child: Center(
                    child: Image(
                      height: 38,
                      width: 32,
                      image: AssetImage(home
                          ? 'assets/images/tasks_d.png'
                          : 'assets/images/tasks.png'),
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.add);
        },
        child: Container(
          height: 56,
          width: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26.5),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(244, 86, 195, 0.47),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(248, 87, 195, 1),
                    Color.fromRGBO(224, 19, 156, 1),
                  ])),
          child: const Center(
            child: Icon(
              CupertinoIcons.add,
              size: 38,
              color: AppColors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildTasks(List<Task> todayList, List<Task> tomorrowList) {
    if (todayList.isEmpty && tomorrowList.isEmpty) {
      return const Empty();
    } else {
      return ListView(padding: const EdgeInsets.all(16), children: [
        Text(
          'Today',
          style: GoogleFonts.rubik(
              color: const Color.fromRGBO(139, 135, 179, 1),
              fontSize: 13,
              fontWeight: FontWeight.w500),
        ),
        buildingTasks(todayList),
        Text(
          'Tomorrow',
          style: GoogleFonts.rubik(
              color: const Color.fromRGBO(139, 135, 179, 1),
              fontSize: 13,
              fontWeight: FontWeight.w500),
        ),
        buildingTasks(tomorrowList),
      ]);
    }
  }

  Widget buildingTasks(List<Task> list) {
    if (list.isEmpty) {
      return const Empty();
    } else {
      return SizedBox(
        height: list.length * 71,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) =>
                task(list[index],false)),
      );
    }
  }

  Widget task(Task task,bool bell) {
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
                    GestureDetector(
                      onTap: (){
                        bell = true;
                        setState(() {
                        });
                      },
                      child: Image.asset(
                        bell?'assets/images/bell_light.png':'assets/images/bell_.png',
                        height: 20,
                        width: 20,
                      ),
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
                                 BorderRadius.all(Radius.circular(17.5)),
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
