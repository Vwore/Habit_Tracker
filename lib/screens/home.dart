import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:persist_ventures/screens/habitCalendar/habitCalendar.dart';
import 'package:persist_ventures/screens/habits/habits.dart';
import 'package:persist_ventures/screens/progressOverview/progressOverview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<bool> loggedIn = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      loggedIn.value = user != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: const Text(
              'Habit Tracker',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              ValueListenableBuilder<bool>(
                  valueListenable: loggedIn,
                  builder: (context, value, child) {
                    return value
                        ? IconButton(
                            icon: const Icon(Icons.logout_sharp),
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                            },
                          )
                        : const SizedBox.shrink();
                  })
            ],
            bottom: const TabBar(
              tabs: [
                Tab(child: Text('Habits')),
                Tab(icon: Icon(Icons.calendar_month)),
                Tab(child: Text('Progress')),
              ],
            ),
          ),
          body: TabBarView(children: [
            const Habits(),
            HabitCalendar(),
            ProgressOverview(),
          ])),
    );
  }
}

      // body: SignOutButton(),
