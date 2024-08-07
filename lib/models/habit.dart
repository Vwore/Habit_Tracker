import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Habit {
  String id;
  String habit;
  DateTime startDate;
  String frequency;
  TimeOfDay? reminderTime;
  bool reminderEnabled;
  String status;
  int streakCount;
  List<DateTime> completionHistory;
  bool completed;

  Habit({
    required this.id,
    required this.habit,
    required this.startDate,
    required this.frequency,
    this.reminderTime,
    this.reminderEnabled = false,
    this.status = 'active',
    this.streakCount = 0,
    this.completionHistory = const [],
    this.completed = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'habit': habit,
        'startDate': Timestamp.fromDate(startDate),
        'frequency': frequency,
        'reminderTime': reminderTime != null
            ? Timestamp.fromDate(DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
                reminderTime!.hour,
                reminderTime!.minute,
              ))
            : null,
        'reminderEnabled': reminderEnabled,
        'status': status,
        'streakCount': streakCount,
        'completionHistory':
            completionHistory.map((date) => Timestamp.fromDate(date)).toList(),
        'completed': completed,
      };

  static Habit fromJson(Map<String, dynamic> json) => Habit(
        id: json['id'],
        habit: json['habit'],
        startDate: (json['startDate'] as Timestamp).toDate(),
        frequency: json['frequency'],
        reminderTime: json['reminderTime'] != null
            ? TimeOfDay(
                hour: (json['reminderTime'] as Timestamp).toDate().hour,
                minute: (json['reminderTime'] as Timestamp).toDate().minute,
              )
            : null,
        reminderEnabled: json['reminderEnabled'],
        status: json['status'],
        streakCount: json['streakCount'],
        completionHistory: (json['completionHistory'] as List<dynamic>?)
                ?.map((e) => (e as Timestamp).toDate())
                .toList() ??
            [],
        completed: json['completed'] ?? false,
      );

  
}
