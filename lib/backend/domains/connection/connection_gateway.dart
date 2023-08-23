import 'package:flutter/material.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:tracely/backend/domains/authentification/authentification_gateway.dart';

import '../../../frontend/config/messages.dart';
import '../../../frontend/routes/errors/error.dart';

connectionGateway() {
  return StreamBuilder(
    stream: Connectivity().checkConnectivity().asStream(),
    builder:
        (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
      if (snapshot.data != ConnectivityResult.none) {
        return StreamBuilder<ConnectivityResult?>(
          stream: Connectivity().onConnectivityChanged,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Error(
                error: snapshot.error.toString(),
              );
            }

            if (snapshot.data != ConnectivityResult.none) {
              return authentificationGateway();
            } else {
              return const Error(
                error: "$noConnection\n$reconnectNeeded",
              );
            }
          },
        );
      } else {
        return const Error(
          error: "$noConnection\n$restartNeeded",
        );
      }
    },
  );
}
