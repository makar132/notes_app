import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String noteText;
  final Widget noteSettings;

  const NoteTile(
      {super.key, required this.noteText, required this.noteSettings});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      margin: const EdgeInsets.only(left: 25, right: 25, top: 10),
      child: ListTile(
        title: Text(noteText),
        trailing: Builder(
            builder: (BuildContext context) => IconButton(
                  onPressed: () => showPopover(
                      height: 100,
                      width: 100,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      context: context,
                      bodyBuilder: (context) => noteSettings),
                  icon: const Icon(Icons.more_vert),
                )),
      ),
    );
  }
}
