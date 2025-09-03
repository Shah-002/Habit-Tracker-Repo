import 'package:flutter/material.dart';
import 'package:habit_tracker/habit_tracker/Provider/habits_provider.dart';
import 'package:provider/provider.dart';

class HabitList extends StatelessWidget {
  const HabitList({super.key});

  @override
  Widget build(BuildContext context) {
    final habitProvider = Provider.of<HabitsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Habit Tracker")),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<HabitsProvider>(context, listen: false).resetHabits();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Daily Progress: ${habitProvider.completedHabits} / ${habitProvider.totalHabit} habits completed",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: habitProvider.totalHabit > 0
                      ? habitProvider.completedHabits / habitProvider.totalHabit
                      : 0,
                ),
                SizedBox(height: 8),
                Text(
                  "Completion Percentage: ${habitProvider.completionPercentage.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: habitProvider.habits.length,
              itemBuilder: (ctx, index) {
                final habit = habitProvider.habits[index];
                return GestureDetector(
                  onLongPress: () {
                    habitProvider.removeHabit(habit.id);
                  },
                  child: ListTile(
                    title: Text(habit.title),
                    trailing: Checkbox(
                      value: habit.isCompleted,
                      onChanged: (_) {
                        habitProvider.toggleHabbit(habit.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              String newHabitTitle = '';
              return AlertDialog(
                title: Text("Add Habit"),
                content: TextField(
                  onChanged: (value) => newHabitTitle = value,
                  decoration: InputDecoration(hintText: "Habit Title"),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (newHabitTitle.isNotEmpty) {
                        habitProvider.addHabit(newHabitTitle);
                        Navigator.of(ctx).pop();
                      }
                    },
                    child: Text("Add"),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
