import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses , required this.onRemoveExpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense; 
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        child: Container(
        width: 280,  // Set your desired width here
        child: ExpenseItem(expenses[index]),
      ),

        onDismissed: (direction){
          onRemoveExpense(expenses[index]);
        },
        key: ValueKey(expenses[index]),
      ),
    );
  }
}
