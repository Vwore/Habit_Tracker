import 'package:flutter/material.dart';
import 'package:persist_ventures/models/habit.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:persist_ventures/provider/habit_provider.dart';

class ProgressOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<HabitListProvider>(
      builder: (context, habitListProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Progress Overview'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildStreaksCard(habitListProvider),
                _buildCompletionRatesChart(habitListProvider),
                _buildOverallProgressCard(habitListProvider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStreaksCard(HabitListProvider habitListProvider) {
    int longestStreak = habitListProvider.habits
        .map((habit) => habit.streakCount)
        .reduce((a, b) => a > b ? a : b);

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Longest Streak',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              '$longestStreak days',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletionRatesChart(HabitListProvider habitListProvider) {
    List<BarChartGroupData> barGroups = [];

    for (var habit in habitListProvider.habits) {
      int totalDays = DateTime.now().difference(habit.startDate).inDays;
      if (totalDays == 0) totalDays = 1; // Avoid division by zero
      double completionRate = habit.completionHistory.length / totalDays;

      print('Habit: ${habit.habit}, Completion Rate: ${completionRate * 100}%');

      barGroups.add(
        BarChartGroupData(
          x: habit.id.hashCode,
          barRods: [
            BarChartRodData(
              y: completionRate * 100,
              colors: [Colors.blue],
            ),
          ],
        ),
      );
    }

    if (barGroups.isEmpty) {
      return const Center(child: Text('No habit completion data available'));
    }

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Habit Completion Rates',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: barGroups.length *
                    100.0, // Adjust width based on number of bars
                height: 300,
                child: BarChart(
                  BarChartData(
                    maxY: 100,
                    barGroups: barGroups,
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: SideTitles(showTitles: true),
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTitles: (double value) {
                          var habit = habitListProvider.habits.firstWhere(
                              (habit) => habit.id.hashCode == value.toInt(),
                              orElse: () => Habit(
                                  id: '',
                                  habit: '',
                                  startDate: DateTime.now(),
                                  frequency: ''));
                          return habit.habit;
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallProgressCard(HabitListProvider habitListProvider) {
    int totalHabits = habitListProvider.habits.length;
    int totalCompleted = habitListProvider.habits
        .map((habit) => habit.completionHistory.length)
        .reduce((a, b) => a + b);

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Overall Progress',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Total Habits: $totalHabits',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Total Completed: $totalCompleted',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
