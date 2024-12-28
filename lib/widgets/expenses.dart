import 'dart:math';

import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/customText.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    // Expense(
    //     title: 'New Year Trip',
    //     amount: 19.99,
    //     date: DateTime.now(),
    //     category: Category.travel),
    // Expense(
    //     title: 'Eating Expenses',
    //     amount: 9.99,
    //     date: DateTime.now(),
    //     category: Category.food),
    // Expense(
    //     title: 'Adventure Expenses ',
    //     amount: 12.99,
    //     date: DateTime.now(),
    //     category: Category.leisure),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue[50],
        duration: Duration(seconds: 3),
        content: CustomText(text: 'Expense Deleted'),
        action: SnackBarAction(

          textColor: Colors.black,
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                _registeredExpenses.insert(expenseIndex, expense);
              },
            );
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: CustomText(text: 'No expenses found'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 198, 251, 206), 
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 198, 251, 206), 
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: Image.asset(
                'assets/images/coin.gif', // Path to your GIF
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              'Dashboard',
              style: TextStyle(
                fontFamily: 'fredoka',
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 14, 62, 62),
              ),
            )
          ],
        ),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [

          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}
