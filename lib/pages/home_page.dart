import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/components/drawer.dart';
import 'package:notes_app/components/note_settings.dart';
import 'package:notes_app/components/note_tile.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_database.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    readNotes();
  }

  final textController = TextEditingController();

  //create
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Create note"),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<NoteDatabase>().createNote(textController.text);

              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Create"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  //read
  void readNotes() {
    context.read<NoteDatabase>().readNotes();
  }

  //update
  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text("Update note"),
        content: TextFormField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Update"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Cancel"),
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  //remove
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
//        title: Text(widget.title),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //header
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              "Notes",
              style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: currentNotes.length,
                itemBuilder: (context, index) {
                  final Note note = currentNotes[index];
                  return NoteTile(
                      noteText: note.text,
                      noteSettings: NoteSettings(
                        noteActions: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              updateNote(note);
                            },
                            child: Container(
                              height: 50,
                              color: Theme.of(context).colorScheme.background,
                              child: Center(
                                  child: Text(
                                "edit",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              )),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              deleteNote(note.id);
                            },
                            child: Container(
                              height: 50,
                              color: Theme.of(context).colorScheme.background,
                              child: Center(
                                  child: Text(
                                "delete",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary),
                              )),
                            ),
                          ),
                        ],
                      ));
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: createNote,
        tooltip: 'Add new note',
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
