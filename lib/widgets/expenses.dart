import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_app/models/expense.dart';
import 'package:expense_app/widgets/new_expences.dart';
//import 'package:expense_app/models/expenses.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Movie',
        amount: 15.94,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _addbutton() {
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

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
        duration: const Duration(seconds: 3),
        content: const Text('expence deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent =
        const Center(child: Text('No Expences found. Start adding some!'));

    if (_registeredExpenses.isNotEmpty) {
      mainContent = Expenseslist(
          expenses: _registeredExpenses, onRemoveExpenses: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My expenses',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: _addbutton, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600 ? Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(
            child: mainContent,
          ),
        ],
      ) : Row(
        children: [
                    Expanded(
                      child: Chart(
                        expenses: _registeredExpenses)),
          Expanded(
            child: mainContent,
          ),
        ],
      )
    );
  }
}
