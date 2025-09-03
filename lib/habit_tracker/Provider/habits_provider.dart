import 'package:flutter/material.dart';
import 'package:habit_tracker/habit_tracker/models/habits_model.dart';

class HabitsProvider extends ChangeNotifier {
  final List<Habits> _habits = [];
  List<Habits> get habits => _habits;
  int get totalHabit => _habits.length;

  //calculate how many habits have been completed
  int get completedHabits => _habits.where((habit) => habit.isCompleted).length;

  //calculate percentage of habits completed
  double get completionPercentage {
    if (totalHabit == 0) return 0;
    return (completedHabits / totalHabit) * 100;
  }

  //function to add new habit
  void addHabit(String title) {
    final newHabit = Habits(id: DateTime.now().toString(), title: title);
    _habits.add(newHabit);
    notifyListeners();
  }

  //toggle habit
  void toggleHabbit(String id) {
    final index = _habits.indexWhere((habits) => habits.id == id);
    if (index != 1) {
      _habits[index].isCompleted = !habits[index].isCompleted;
      notifyListeners();
    }
  }

  //reset habits
  void resetHabits() {
    for (var habit in _habits) {
      habit.isCompleted = false;
    }
    notifyListeners();
  }

  //to delete
  void removeHabit(String id) {
    _habits.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }
}
