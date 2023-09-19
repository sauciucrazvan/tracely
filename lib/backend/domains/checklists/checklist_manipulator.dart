import 'package:firebase_database/firebase_database.dart';

import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

/*

  FUNCTIONS

*/

void insertChecklist(String name, String color) async {
  String userId = getUID();

  String id = DateTime.now().millisecondsSinceEpoch.toString();

  await database.child("users/$userId/checklists/$id").set({
    'title': name,
    'color': color,
  });
}

void editChecklist(String id, String name, String color) async {
  String userId = getUID();

  await database.child("users/$userId/checklists/$id").update({
    'title': name,
    'color': color,
  });
}

void markChecklistPinned(String id, bool pinned) async {
  String userId = getUID();

  await database.child("users/$userId/checklists/$id").update({
    'pinned': !pinned,
  });
}

void deleteChecklist(String id) async {
  String userId = getUID();

  await database.child("users/$userId/checklists/$id").remove();
}

Stream getChecklistsStream() {
  String userId = getUID();

  return database.child("users/$userId/checklists").onValue.asBroadcastStream();
}
