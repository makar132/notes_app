import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:notes_app/models/note.dart';
import 'package:path_provider/path_provider.dart';

class NoteDatabase extends ChangeNotifier {
  //INITIALIZE
  static late Isar isar;

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  final List<Note> currentNotes = [];

//C
  Future<void> createNote(String text) async {
    final newNote = (Note()..text = text);
    await isar.writeTxn(() => isar.notes.put(newNote));
    await readNotes();
  }

//R
  Future<void> readNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners();
  }

//U
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await readNotes();
    }
  }

//D
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await readNotes();
  }
}
