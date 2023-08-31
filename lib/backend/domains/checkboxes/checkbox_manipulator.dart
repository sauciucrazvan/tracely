import 'package:firebase_database/firebase_database.dart';

import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

/*

  FUNCTIONS

*/

void insertCheckbox(String categoryID, String name, String date) async {
  String userId = getUID();

  String checkboxID = DateTime.now().millisecondsSinceEpoch.toString();

  await database
      .child("users/$userId/checklists/$categoryID/checkboxes/$checkboxID")
      .set({
    'title': name,
    'date': date,
    'checked': false,
  });
}

void markCheckbox(String categoryID, String checkboxID, bool value) async {
  String userId = getUID();

  await database
      .child("users/$userId/checklists/$categoryID/checkboxes/$checkboxID")
      .update({
    'checked': value,
  });
}

void deleteCheckbox(String categoryID, String checkboxID) async {
  String userId = getUID();

  await database
      .child("users/$userId/checklists/$categoryID/checkboxes/$checkboxID")
      .remove();
}
