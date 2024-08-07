import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../services/firebase_service.dart';

class HabitListProvider extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  List<Habit> habits = [];

  Future<void> addHabit(Habit habit) async {
    await _firebaseService.addHabit(habit);
    getHabit();
  }

  Future<void> getHabit() async {
    final newHabits = await _firebaseService.getHabits();
    if (newHabits != null) {
      habits = newHabits;
      notifyListeners();
    }
  }

  Future<void> updateHabit(Habit habit) async {
    await _firebaseService.updateHabit(habit);
    getHabit();
  }

  Future<void> deleteHabit(String id) async {
    await _firebaseService.deleteHabit(id);
    getHabit();
  }

  Future<void> resetCompleted() async {
    await _firebaseService.resetCompleted();
    await getHabit(); // Fetch the updated list
  }

  List<Habit> getHabitsForDay(DateTime day) {
    return habits.where((habit) {
      return habit.completionHistory.any((completedDate) {
        return completedDate.year == day.year &&
            completedDate.month == day.month &&
            completedDate.day == day.day;
      });
    }).toList();
  }
}
