import 'package:flutter/material.dart';

import '../../../../config/messages.dart';
import '../../components/titlebar.dart';

class TodoDashboard extends StatelessWidget {
  const TodoDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),

          // TO DO
          titleBar(
            context,
            todo,
            todoRoute,
            () => {},
          ),

          // const Expanded(
          //   child: SingleChildScrollView(
          //     child: BuildTodo(),
          //   ),
          // ),
        ],
      ),
    );
  }
}
