import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import 'package:tracely/backend/domains/expenses/expenses_manipulator.dart';
import 'package:tracely/frontend/routes/expenses/edit/edit_expense.dart';

import '../../config/messages.dart';
import '../../widgets/dialogs/dialog.dart';

class ExpenseWidget extends StatelessWidget {
  final String id;
  final String expense;
  final String currency;
  final double value;
  final String date;

  const ExpenseWidget({
    super.key,
    required this.id,
    required this.expense,
    required this.currency,
    required this.value,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    Color primaryColor = Theme.of(context).colorScheme.primary;

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.lightGreen.shade800,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            onPressed: (context) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditExpense(
                  id: id,
                  expense: expense,
                  currency: currency,
                  value: value,
                  date: date,
                ),
              ),
            ),
          ),
          SlidableAction(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            onPressed: (context) => showDialog(
              context: context,
              builder: (context) => ConfirmDialog(
                title: removeExpense,
                confirm: () {
                  deleteExpense(id);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: Text(
                    expense,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.attach_money,
                      color: primaryColor,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "$currency $value",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timer,
                      color: textColor,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      DateFormat("MMM d, yyyy").format(
                        DateTime.parse(date),
                      ),
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 64,
              child: Icon(
                Icons.keyboard_tab,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
