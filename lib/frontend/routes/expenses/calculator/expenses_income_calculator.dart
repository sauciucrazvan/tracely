import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tracely/backend/domains/expenses/expenses_manipulator.dart';
import 'package:tracely/frontend/config/messages.dart';
import 'package:tracely/frontend/widgets/buttons/button.dart';

import '../../../../backend/functions/convert_currencies.dart';

class ExpensesIncomeCalculator extends StatefulWidget {
  const ExpensesIncomeCalculator({super.key});

  @override
  State<ExpensesIncomeCalculator> createState() =>
      _ExpensesIncomeCalculatorState();
}

class _ExpensesIncomeCalculatorState extends State<ExpensesIncomeCalculator> {
  TextEditingController incomeController = TextEditingController();
  String selectedCurrency = "EUR";

  double income = 0;

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).textTheme.bodyMedium!.color!;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    Color primaryColor = Theme.of(context).colorScheme.primary;

    return StreamBuilder(
      stream: getExpensesStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();

        if (snapshot.data?.snapshot.value != null &&
            snapshot.data?.snapshot.value is Map) {
          final expenses =
              snapshot.data?.snapshot.value as Map<dynamic, dynamic>;

          final expensesList = expenses.entries.toList();

          double totalSpent = 0;

          for (var element in expensesList) {
            totalSpent += convertToEuro(
              double.parse(element.value['value'].toString()),
              element.value['currency'],
            );
          }

          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  monthlyIncome,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                      child: DropdownButtonFormField<String>(
                        value: selectedCurrency,
                        onChanged: (String? currency) {
                          setState(() {
                            selectedCurrency = currency!;
                          });
                        },
                        items: currencies
                            .map<DropdownMenuItem<String>>((String currency) {
                          return DropdownMenuItem<String>(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: secondaryColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                        ),
                        style: TextStyle(color: textColor),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: TextField(
                        controller: incomeController,
                        maxLength: 128,
                        maxLines: 1,
                        obscureText: false,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d*')),
                        ],
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: secondaryColor,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor),
                          ),
                          counterText: '',
                        ),
                        style: TextStyle(color: textColor),
                      ),
                    ),
                    const SizedBox(width: 4),
                    SmallButton(
                      icon: Icons.calculate_rounded,
                      color: primaryColor,
                      pressed: () {
                        if (incomeController.text.isEmpty) return;
                        setState(() {
                          income = convertToEuro(
                              double.parse(incomeController.text),
                              selectedCurrency);
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  result,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                (income != 0)
                    ? Text(
                        "${(totalSpent / (income * 2) * 100).round()}% $spentIncome",
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    : Text(
                        noIncomeProvided,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                noExpensesSaved,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
