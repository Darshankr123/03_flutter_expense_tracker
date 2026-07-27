import 'package:expense_tracker/widgets/chart/chart.dart';
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
  final DateTime date = DateTime.now();

  late final List<Expense> expensesList = [
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

  void _openExpenseModalOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(addExpense: _addExpenses);
      },
    );
  }

  void _addExpenses(Expense expense) {
    setState(() {
      expensesList.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    var expenseIndex = expensesList.indexOf(expense);
    setState(() {
      expensesList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text("Expense deleted."),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              expensesList.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final deviceWidth = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expense found. Start adding some!'),
    );

    if (expensesList.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: expensesList,
        onRemoveExpense: _removeExpense,
      );
    }

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
        // backgroundColor: Colors.purple,
      ),
      body:
      deviceWidth < 600 ? Column(
        children: [
          Chart(expenses: expensesList),
          Expanded(child: mainContent),
        ],
      ) :
      Row(
        children: [
          Expanded(child: Chart(expenses: expensesList)),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
