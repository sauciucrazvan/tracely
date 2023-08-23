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
          return const Authentification();
        } else {
          setUser(FirebaseAuth.instance.currentUser!);
          return const Dashboard();
        }
      }

      return const Loading();
    },
  );
}
