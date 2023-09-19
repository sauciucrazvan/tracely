import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';

class FullStatisticWidget extends StatefulWidget {
  final Map<String, Map<String, dynamic>> entries;

  const FullStatisticWidget({super.key, required this.entries});

  @override
  State<FullStatisticWidget> createState() => _FullStatisticWidgetState();
}

class _FullStatisticWidgetState extends State<FullStatisticWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.entries.length,
          itemBuilder: (context, index) {
            return StreamBuilder<DatabaseEvent>(
              stream: widget.entries.values.elementAt(index)['stream'],
              builder: (context, snapshot) {
                int value = 0;

                if (snapshot.hasData && snapshot.data?.snapshot.value is Map) {
                  Map<dynamic, dynamic> map =
                      snapshot.data?.snapshot.value as Map;
                  value = map.length;
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.entries.entries.elementAt(index).key,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          "$value",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          widget.entries.values.elementAt(index)['icon'],
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
