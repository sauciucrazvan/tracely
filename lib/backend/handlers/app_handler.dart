import 'package:flutter/material.dart';

import 'package:tracely/frontend/config/palette.dart';

import '../domains/connection/connection_gateway.dart';

class Tracely extends StatelessWidget {
  const Tracely({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      title: 'Tracely',
      home: connectionGateway(),
    );
  }
}
