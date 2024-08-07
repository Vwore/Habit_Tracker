import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:persist_ventures/provider/habit_provider.dart';
import 'package:persist_ventures/models/habit.dart';

class HabitCalendar extends StatefulWidget {
  @override
  _HabitCalendarState createState() => _HabitCalendarState();
}

class _HabitCalendarState extends State<HabitCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitListProvider>(
      builder: (context, habitListProvider, child) {
        return Column(
          children: [
            TableCalendar<Habit>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              eventLoader: (day) {
                return habitListProvider.getHabitsForDay(day);
              },
              calendarStyle: const CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: habitListProvider.habits.length,
                itemBuilder: (context, index) {
                  final habit = habitListProvider.habits[index];
                  final isSelectedDateCompleted = habit.completionHistory.any(
                    (completedDate) {
                      return isSameDay(completedDate, _selectedDay);
                    },
                  );
                  return ListTile(
                    title: Text(habit.habit),
                    tileColor: isSelectedDateCompleted ? Colors.green : null,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
