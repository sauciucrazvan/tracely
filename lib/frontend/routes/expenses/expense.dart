import 'package:flutter/material.dart';

import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:tracely/backend/domains/expenses/expenses_manipulator.dart';

import '../../config/messages.dart';
import '../../widgets/dialogs/dialog.dart';

class ExpenseWidget extends StatelessWidget {
  final String id;
  final String expense;
  final String currency;
  final double value;

  const ExpenseWidget({
    super.key,
    required this.id,
    required this.expense,
    required this.currency,
    required this.value,
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
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            onPressed: (context) => showDialog(
              context: context,
              builder: (context) => alertDialog(
                context,
                removeExpense,
                () {
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
                Text(
                  "$currency $value",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 12,
                  ),
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
