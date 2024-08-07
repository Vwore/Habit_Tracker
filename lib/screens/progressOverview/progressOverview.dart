import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:persist_ventures/provider/habit_provider.dart';

class ProgressOverview extends StatelessWidget {
  const ProgressOverview({super.key});

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
            AspectRatio(
              aspectRatio: 1.7,
              child: BarChart(
                BarChartData(
                  barGroups: habitListProvider.habits.map((habit) {
                    double completionRate =
                        habit.completionHistory.length /
                            DateTime.now().difference(habit.startDate).inDays;
                    return BarChartGroupData(
                      x: habit.id.hashCode,
                      barRods: [
                        BarChartRodData(
                          y: completionRate * 100,
                          colors: [Colors.blue],
                        ),
                      ],
                    );
                  }).toList(),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(show: false),
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
            Text(
              'Total Completions: $totalCompleted',
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
