import 'package:encrypt/encrypt.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tracely/backend/keys/encryption_key.dart';
import 'package:tracely/frontend/config/messages.dart';

import '../../handlers/users/account_handler.dart';

final DatabaseReference database = FirebaseDatabase.instance.ref();

/*

  FUNCTIONS

*/

void insertGoal(
    String goal, String details, String deadline, int maxProgress) async {
  String userId = getUID();

  String goalID = DateTime.now().millisecondsSinceEpoch.toString();
  IV iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(getEncryptionKey()));
  final encryptedGoal = encrypter.encrypt(goal, iv: iv).base64;
  final encryptedDetails = encrypter.encrypt(details, iv: iv).base64;

  await database.child("users/$userId/goals/$goalID").set({
    'goal': encryptedGoal,
    'details': encryptedDetails,
    'iv': iv.base64,
    'deadline': deadline,
    'progress': 0,
    'maxProgress': maxProgress,
  });
}

void updateGoalProgress(String goalID, int progress) async {
  String userId = getUID();

  await database.child("users/$userId/goals/$goalID").update({
    'progress': progress,
  });
}

void updateGoal(String goalID, String goal, String details, String deadline,
    int maxProgress) async {
  String userId = getUID();

  IV iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(getEncryptionKey()));
  final encryptedGoal = encrypter.encrypt(goal, iv: iv).base64;
  final encryptedDetails = encrypter.encrypt(details, iv: iv).base64;

  await database.child("users/$userId/goals/$goalID").update({
    'goal': encryptedGoal,
    'details': encryptedDetails,
    'iv': iv.base64,
    'deadline': deadline,
    'progress': 0, // Reseting the progress on edit
    'maxProgress': maxProgress,
  });
}

void encryptGoal(String goalID, String goal, String details) async {
  String userId = getUID();

  IV iv = IV.fromLength(16);

  if (details.isEmpty) details = noDetailsAttached;

  final encrypter = Encrypter(AES(getEncryptionKey()));
  final encryptedGoal = encrypter.encrypt(goal, iv: iv).base64;
  final encryptedDetails = encrypter.encrypt(details, iv: iv).base64;

  await database.child("users/$userId/goals/$goalID").update({
    'goal': encryptedGoal,
    'details': encryptedDetails,
    'iv': iv.base64,
  });
}

void deleteGoal(String goalID) async {
  String userId = getUID();

  await database.child("users/$userId/goals/$goalID").remove();
}

Stream getGoalsStream() {
  String userId = getUID();
  return database.child("users/$userId/goals").onValue.asBroadcastStream();
}
