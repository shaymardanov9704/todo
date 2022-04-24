import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject{
  @HiveField(0)
  late String taskName;

  @HiveField(1)
  late String status;

  @HiveField(2)
  late DateTime dateTime;

  @HiveField(3)
  late int hour;

  @HiveField(4)
  late int minute;
}