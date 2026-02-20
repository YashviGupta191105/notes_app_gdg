import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/note.dart';
import '../widgets/note_fab.dart';
import '../widgets/notes_grid.dart';
import 'new_or_edit_note_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Box<Note> notesBox;

  @override
  void initState() {
    super.initState();
    notesBox = Hive.box<Note>('notes');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes 📒'),
      ),
      floatingActionButton: NoteFab(
        onPressed: () async {
          // Open page to create new note
          final newNote = await Navigator.push<Note>(
            context,
            MaterialPageRoute(
              builder: (_) => const NewOrEditNotePage(isNewNote: true),
            ),
          );

          // Add new note to the list
          if (newNote != null) {
            notesBox.add(newNote);
            setState(() {}); // Refresh the UI to show the new note
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Expanded so the grid can take all remaining space
            Expanded(
              child: notesBox.isEmpty
                  ? const Center(
                      child: Text(
                        'No notes yet',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : NotesGrid(
                      notes: notesBox.values.toList(),
                      onNoteTap: (index) async {
                        // Open page to edit the tapped note
                        final updatedNote = await Navigator.push<Note>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NewOrEditNotePage(
                              isNewNote: false,
                              note: notesBox.values.toList()[index],
                            ),
                          ),
                        );

                        // Update the note in the list if edited
                        if (updatedNote != null) {
                          notesBox.putAt(index, updatedNote);
                          setState(() {}); // Refresh the UI to show the updated note
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
