import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final List<Widget> noteActions;

  const NoteSettings({super.key, required this.noteActions});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(children: noteActions),
    );
  }
}
