import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/customText.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: 
        Card(
          color: Color.fromARGB(201, 151, 255, 166),
                shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),  // Set your desired border radius here
      ),

          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ), // Add padding around the Text
        
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: expense.title,
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    CustomText(
                      text: '\$ ${expense.amount.toStringAsFixed(2)}',
                      isSmall: true,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(categoryIcons[expense.category]),
                        const SizedBox(width: 8,),
                        CustomText(text: expense.formattedDate, isSmall: true,)
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      
    );
  }
}
