import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tracely/backend/handlers/users/account_handler.dart';

import 'package:tracely/frontend/routes/authentification/authentification.dart';
import 'package:tracely/frontend/routes/dashboard/dashboard.dart';
import 'package:tracely/frontend/routes/loading/loading.dart';

StreamBuilder<User?> authentificationGateway() {
  return StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasError) return ErrorWidget(snapshot.error.toString());

      if (snapshot.connectionState == ConnectionState.active) {
        if (snapshot.data == null) {
          // Database going offline while signed out
          FirebaseDatabase.instance.goOffline();

          // Creating the authentification page
          return const Authentification();
        } else {
          // Database going online after sign in
          FirebaseDatabase.instance.goOnline();

          // Updating the user after changing the account
          setUser(FirebaseAuth.instance.currentUser!);

          // Creating the dashboard
          return const Dashboard();
        }
      }

      return const Loading();
    },
  );
}
