import 'package:flutter/material.dart';
import 'package:persist_ventures/models/habit.dart';
import 'package:persist_ventures/provider/habit_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HabitFormDialog extends StatefulWidget {
  const HabitFormDialog({super.key});

  @override
  _HabitFormDialogState createState() => _HabitFormDialogState();
}

class _HabitFormDialogState extends State<HabitFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _habitController = TextEditingController();
  final TextEditingController _frequencyController = TextEditingController();
  final TextEditingController _reminderTimeController = TextEditingController();
  bool _reminderEnabled = false;

  TimeOfDay? _selectedTime;

  TimeOfDay? parseTimeOfDay(String? time) {
    if (time == null || time.isEmpty) return null;
    final parts = time.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    return TimeOfDay(hour: hour, minute: minute);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _reminderTimeController.text = _selectedTime!.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitListProvider>(
      builder: (context, habitListProvidermodel, child) => AlertDialog(
        title: const Text('Add Habit'),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _habitController,
                  decoration: const InputDecoration(labelText: 'Habit'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a habit';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _frequencyController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: 'Frequency (e.g., once a day)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a frequency';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _reminderEnabled,
                      onChanged: (value) {
                        setState(() {
                          _reminderEnabled = value!;
                        });
                      },
                    ),
                    const Text('Enable Reminder'),
                  ],
                ),
                if (_reminderEnabled)
                  TextFormField(
                    controller: _reminderTimeController,
                    decoration: const InputDecoration(
                        labelText: 'Reminder Time (e.g., 08:00 AM)'),
                    onTap: () {
                      _selectTime(context);
                    },
                    validator: (value) {
                      if (_reminderEnabled &&
                          (value == null || value.isEmpty)) {
                        return 'Please enter a reminder time';
                      }
                      return null;
                    },
                  ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Process the input data
                String habit = _habitController.text;
                String frequency = _frequencyController.text;
                bool reminderEnabled = _reminderEnabled;
                String? reminderTime =
                    _reminderEnabled ? _reminderTimeController.text : null;

                habitListProvidermodel.addHabit(Habit(
                    id: const Uuid().v4(),
                    habit: habit,
                    startDate: DateTime.now(),
                    frequency: frequency,
                    reminderTime: parseTimeOfDay(reminderTime),
                    reminderEnabled: reminderEnabled));
                // Print or save the input data
                print('Habit: $habit');
                print('Frequency: $frequency');
                print('Reminder Enabled: $reminderEnabled');
                if (reminderEnabled) {
                  print('Reminder Time: $reminderTime');
                }

                // Close the dialog
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
