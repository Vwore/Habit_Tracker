// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persist_ventures/models/habit.dart';
import 'package:persist_ventures/screens/habits/HabitForm.dart';
import 'package:persist_ventures/provider/habit_provider.dart';
import 'package:provider/provider.dart';

class Habits extends StatefulWidget {
  const Habits({super.key});

  @override
  State<Habits> createState() => _HabitsState();
}

class _HabitsState extends State<Habits> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  late Future<void> _loadHabitsFuture;

  @override
  void initState() {
    super.initState();
    _loadHabitsFuture = _loadHabits();
  }

  Future<void> _loadHabits() async {
    final habitProvider =
        Provider.of<HabitListProvider>(context, listen: false);
    await habitProvider.getHabit();
  }

  @override
  Widget build(BuildContext context) {
    // final habitProvider = Provider.of<HabitListProvider>(context);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => const HabitFormDialog(),
            );
          },
          child: const Text('Add Habit'),
        ),
        FutureBuilder(
            future: _loadHabitsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                return const Expanded(
                    child: Center(child: Text('Error loading habits')));
              } else {
                return Consumer<HabitListProvider>(
                    builder: (context, habitListProvider, child) {
                  return Expanded(
                    child: (habitListProvider.habits.isEmpty)
                        ? const Center(child: Text('No habits found'))
                        : ListView.builder(
                            itemCount: habitListProvider.habits.length,
                            itemBuilder: (BuildContext context, int index) {
                              final habit = habitListProvider.habits[index];
                              return ListTile(
                                tileColor:
                                    habit.completed ? Colors.green[100] : null,
                                title: Text(habit.habit),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                   
                                    (habit.completed)
                                        ? const SizedBox()
                                        : IconButton(
                                            icon: const Icon(Icons.check_box_outline_blank),
                                            onPressed: () {
                                              List<DateTime> history =
                                                  habit.completionHistory;
                                              history.add(DateTime.now());
                                              habitListProvider
                                                  .updateHabit(Habit(
                                                id: habit.id,
                                                habit: habit.habit,
                                                startDate: habit.startDate,
                                                frequency: habit.frequency,
                                                reminderEnabled:
                                                    habit.reminderEnabled,
                                                reminderTime:
                                                    habit.reminderTime,
                                                status: habit.status,
                                                completionHistory: history,
                                                streakCount: habit.streakCount,
                                                completed: !habit.completed,
                                              ));
                                            },
                                          ),
                                           IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        _showEditDialog(
                                            context, habit, habitListProvider);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  );
                });
              }
            })
      ],
    );
  }
}

void _showEditDialog(
    BuildContext context, Habit habit, HabitListProvider habitListProvider) {
  final TextEditingController habitController =
      TextEditingController(text: habit.habit);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Habit'),
        content: TextField(
          controller: habitController,
          decoration: InputDecoration(labelText: 'Habit'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              habitListProvider.updateHabit(Habit(
                id: habit.id,
                habit: habitController.text,
                startDate: habit.startDate,
                frequency: habit.frequency,
                reminderEnabled: habit.reminderEnabled,
                reminderTime: habit.reminderTime,
                status: habit.status,
                completionHistory: habit.completionHistory,
                streakCount: habit.streakCount,
                completed: habit.completed,
              ));
              Navigator.of(context).pop();
            },
            child: Text('Save'),
          ),
          TextButton(
              onPressed: () {
                habitListProvider.deleteHabit(habit.id);
                Navigator.of(context).pop();
              },
              child: Text('Delete')),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        ],
      );
    },
  );
}
