import 'package:expenseapp/constants/icons.dart';
import 'package:expenseapp/models/database_provider.dart';
import 'package:expenseapp/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  DateTime? _date;
  String? _initialValue;

  _pickDate() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (_pickedDate != null) {
      setState(() {
        _date = _pickedDate;
      });
    }
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _initialValue = 'Others';
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: true);
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                labelText: 'Title of expense',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _amount,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              decoration: const InputDecoration(
                labelText: 'Amount of expense',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  _date != null
                      ? DateFormat('MMMM dd, yyyy').format(_date!)
                      : 'Date Time',
                  style: const TextStyle(fontSize: 20),
                )),
                IconButton(
                    onPressed: () => _pickDate(),
                    icon: const Icon(Icons.calendar_month))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Expanded(child: Text('Category')),
                Expanded(
                    child: DropdownButton(
                  items: icons.keys
                      .map((e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  value: _initialValue,
                  hint: const Text('Other'),
                  isDense: true,
                  onChanged: (value) => setState(() => _initialValue = value!),
                )),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_title.text != '' || _amount.text != '') {
                  final expense = Expense(
                    id: 0,
                    title: _title.text,
                    amount: double.parse(_amount.text),
                    date: _date != null ? _date! : DateTime.now(),
                    category: _initialValue != null ? _initialValue! : 'Others',
                  );
                  provider.addExpense(expense);
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Expense'),
            )
          ],
        ),
      ),
    );
  }
}
