import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {

  void _openExpenseModalOverlay(){
    showModalBottomSheet(context: context, builder: (ctx){
      return const NewExpense();
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime date = DateTime.now();

    final List<Expense> expensesList = [
      Expense(
        title: "Flutter Course",
        amount: 19.89,
        date: DateTime(date.year, date.day, date.hour),
        category: Category.Work,
      ),
      Expense(
        title: "lunch",
        amount: 20.0,
        date: DateTime(date.year, date.day, date.hour),
        category: Category.Food,
      ),
      Expense(
        title: "travel",
        amount: 22.0,
        date: DateTime(date.year, date.day, date.hour),
        category: Category.Travel,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Expense Tracker",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _openExpenseModalOverlay,
            icon: Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ],
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          // Text('chart'),
          Expanded(child: ExpensesList(expenses: expensesList)),
        ],
      ),
    );
  }
}
