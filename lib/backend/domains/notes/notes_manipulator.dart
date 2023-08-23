import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();
final User? currentUser = FirebaseAuth.instance.currentUser;

String userId = currentUser!.uid;

/*

  FUNCTIONS

*/

void insertNote(String title, String content) async {
  String id = DateTime.now().millisecondsSinceEpoch.toString();

  await database.child("users/$userId/notes/$id").set({
    'title': title,
    'content': content,
    'last_edit': DateTime.now().toString(),
  });
}

void editNote(String id, String title, String content) async {
  await database.child("users/$userId/notes/$id").update({
    'title': title,
    'content': content,
    'last_edit': DateTime.now().toString(),
  });
}

void deleteNote(String id) async =>
    await database.child("users/$userId/notes/$id").remove();
