import 'package:expense_app/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectDate;
  Category _selectedcategory = Category.food;

  void _showdate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectDate = pickDate;
    });
  }

  void _submitData() {
    final enterAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enterAmount == null || enterAmount < 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content:
                    const Text('please make to select date time and expence'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Okay'))
                ],
              ));
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amount: enterAmount,
        date: _selectDate!,
        category: _selectedcategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height:double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.fromLTRB(16, 16, 16,keyboardSpace +16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
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
                        label: Text('amount'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(_selectDate == null
                            ? 'No select Date'
                            : formatter.format(_selectDate!)),
                        IconButton(
                            onPressed: _showdate,
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownButton(
                      value: _selectedcategory,
                      items: Category.values
                          .map(
                            (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                )),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedcategory = value;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _submitData();
                      },
                      child: const Text('Save'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
