import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';

class Expenseslist extends StatelessWidget {
  const Expenseslist(
      {super.key, required this.expenses, required this.onRemoveExpenses});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey((expenses[index])),
        background: Container(color: Theme.of(context).colorScheme.error,),
        onDismissed: (direction) {
          onRemoveExpenses(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
