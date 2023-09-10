import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:tracely/backend/keys/firebase_options.dart';

import 'package:tracely/backend/handlers/app_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const Tracely());
}
