import 'package:expense_tracker/widgets/customText.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:expense_tracker/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key,required this.onAddExpense});

  final void Function(Expense expense )onAddExpense ;
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: lastDate);
    if (pickedDate != null) {
      // Handle case when no date is picked
      setState(() {
        _selectedDate = pickedDate; // Correct assignment
      });
      print(_selectedDate);
    } else {
      print("No date selected");
    }
  }

  void _submitExpeneseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const CustomText(
            text: 'Invalid Input',
            isSmall: false,
          ),
          content: const CustomText(
            text:
                'Please make sure a valid title,amount,date-time and category was enetered ',
            isSmall: true,
          ),
          actions: [
            ElevatedButton(
                
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const CustomText(
                  text: 'Okay',
                  isSmall: true,
                  
                ))
          ],
        ),
      );
      return ;

    }

    widget.onAddExpense(
      Expense(title: _titleController.text, amount: enteredAmount, category: _selectedCategory, date: _selectedDate!)
    );

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: const InputDecoration(
              label: CustomText(
                text: 'Title',
                isSmall: true,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: CustomText(
                      text: 'Amount',
                      isSmall: true,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText(
                    text: _selectedDate == null
                        ? 'No date selected'
                        : formatter.format(_selectedDate!),
                    isSmall: true,
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ))
            ],
          ),
          const SizedBox(
            height: 28,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  width: 38,
                  child: DropdownButton(
                      value: _selectedCategory,
                      items: Category.values.map((category) {
                        return DropdownMenuItem<Category>(
                          value: category,
                          child: Row(
                            children: [
                              Icon(
                                  categoryIcons[category]), // Icon from the map
                              const SizedBox(width: 8),
                              CustomText(
                                text: category.name.toUpperCase(),
                                isSmall: true,
                              ), // Enum value name (requires Dart >= 2.15)
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      }),
                ),
              ),
              // const SizedBox(width: 8,),
              TextButton(
                  onPressed: () => {
                        Navigator.pop(context),
                      },
                  child: CustomText(
                    text: 'Cancel',
                    isSmall: true,
                  )),
              ElevatedButton(
                  onPressed: _submitExpeneseData,
                  child: CustomText(
                    text: 'Save Expense  ',
                    isSmall: true,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
