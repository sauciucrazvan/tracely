import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tracely/frontend/config/messages.dart';

import 'package:tracely/backend/domains/expenses/expenses_manipulator.dart';

import '../../../../widgets/buttons/back_button.dart';
import '../../../../widgets/buttons/button.dart';
import '../../../../widgets/header/header.dart';
import '../../../../widgets/notifications/elevated_notification.dart';

class EditExpenseDesktopLayout extends StatefulWidget {
  final String id;
  final String expense;
  final String currency;
  final double value;
  final String date;

  const EditExpenseDesktopLayout({
    super.key,
    required this.id,
    required this.expense,
    required this.currency,
    required this.value,
    required this.date,
  });

  @override
  State<EditExpenseDesktopLayout> createState() =>
      _EditExpenseDesktopLayoutState();
}

class _EditExpenseDesktopLayoutState extends State<EditExpenseDesktopLayout> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  String selectedCurrency = "EUR";

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(
        const Duration(
          days: 60,
        ),
      ),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    _titleController.text = widget.expense;
    _valueController.text = widget.value.toString();
    selectedCurrency = widget.currency;
    selectedDate = DateTime.parse(widget.date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Theme.of(context).colorScheme.tertiary;
    Color backgroundColor = Theme.of(context).colorScheme.background;
    Color secondaryColor = Theme.of(context).colorScheme.secondary;
    Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: header(
        Image.asset(
          "assets/logo.png",
          height: 32,
          width: 32,
        ),
        backgroundColor,
        true,
        leading: const BackLeadingButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 256.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.asset(
                    "assets/animations/expenses.json",
                    height: 128,
                    width: 128,
                  ),
                ),

                Text(
                  modifyExpense,
                  style: GoogleFonts.arimo(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // expense title
                Text(
                  chooseTitleExpense,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: TextField(
                    controller: _titleController,
                    maxLength: 128,
                    maxLines: 1,
                    obscureText: false,
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

                const SizedBox(
                  height: 25,
                ),

                const Divider(),

                // expense value
                const SizedBox(
                  height: 25,
                ),

                Text(
                  chooseValueExpense,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
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
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextField(
                        controller: _valueController,
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
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                const Divider(),

                // date selector
                const SizedBox(
                  height: 25,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectExpenseDate,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat("MMM dd, yyyy").format(selectedDate),
                          style: TextStyle(
                            color: textColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        actionButton(
                          context,
                          backgroundColor: secondaryColor,
                          icon: Icons.calendar_today,
                          onPressed: () => selectDate(context),
                        ),
                      ],
                    ),
                  ],
                ),

                // add/cancel button
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    actionButton(
                      context,
                      backgroundColor: primaryColor,
                      icon: Icons.done,
                      onPressed: () {
                        String text = _titleController.text;
                        if (text.isEmpty) {
                          return showElevatedNotification(
                              context, expenseWithoutName, Colors.red);
                        }

                        if (_valueController.text.isEmpty) {
                          return showElevatedNotification(
                              context, expenseWithoutValue, Colors.red);
                        }

                        double value = double.parse(_valueController.text);

                        //edit
                        editExpense(
                          widget.id,
                          text,
                          selectedCurrency,
                          value,
                          selectedDate.toString(),
                        );

                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    actionButton(
                      context,
                      backgroundColor: Colors.red,
                      icon: Icons.close,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
