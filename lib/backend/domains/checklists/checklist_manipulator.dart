import 'package:firebase_database/firebase_database.dart';

import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();
String userId = getUID();

void insertChecklist(String name) async {
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  await database.child("users/$userId/checklists/$id").set({
    'title': name,
  });
}

void removeChecklist(String id) async {
  await database.child("users/$userId/checklists/$id").remove();
}
