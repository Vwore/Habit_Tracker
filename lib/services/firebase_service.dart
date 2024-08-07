import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/habit.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final habitsRef = FirebaseFirestore.instance.collection('User');

  Future<void> addHabit(Habit habit) async {
    await habitsRef
        .doc(_auth.currentUser?.email)
        .collection('Habit')
        .doc(habit.id)
        .set(habit.toJson());
  }

  Future<List<Habit>?> getHabits() async {
    if (_auth.currentUser?.email == null) {
      print('No authenticated user.');
      return null;
    }

    try {
      final querySnapshot = await habitsRef
          .doc(_auth.currentUser!.email)
          .collection('Habit')
          .get();

      if (querySnapshot.docs.isEmpty) {
        print('No habits found in Firestore.');
        return [];
      } else {
        return querySnapshot.docs.map((doc) {
          final data = doc.data();
          print('Document data: $data');
          return Habit.fromJson(data);
        }).toList();
      }
    } catch (e) {
      print('Error loading habits: $e');
      return null;
    }
  }

  Future<void> updateHabit(Habit habit) async {
    await habitsRef
        .doc(_auth.currentUser?.email)
        .collection('Habit')
        .doc(habit.id)
        .update(habit.toJson());
  }

  Future<void> deleteHabit(String id) async {
    await habitsRef.doc(_auth.currentUser?.email)
        .collection('Habit')
        .doc(id).delete();
  }

  Future<void> resetCompleted() async {
    if (_auth.currentUser?.email == null) {
      print('No authenticated user.');
      return;
    }

    try {
      final querySnapshot = await habitsRef
          .doc(_auth.currentUser!.email)
          .collection('Habit')
          .get();

      for (var doc in querySnapshot.docs) {
        await habitsRef
            .doc(_auth.currentUser!.email)
            .collection('Habit')
            .doc(doc.id)
            .update({'completed': false});
      }
    } catch (e) {
      print('Error resetting completed field: $e');
    }
  }
}
