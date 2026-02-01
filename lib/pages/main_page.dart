import 'package:flutter/material.dart';
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
  final List<Note> notes = [];

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
            setState(() => notes.add(newNote));
          }
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Expanded so the grid can take all remaining space
            Expanded(
              child: notes.isEmpty
                  ? const Center(
                      child: Text(
                        'No notes yet',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  : NotesGrid(
                      notes: notes,
                      onNoteTap: (index) async {
                        // Open page to edit the tapped note
                        final updatedNote = await Navigator.push<Note>(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NewOrEditNotePage(
                              isNewNote: false,
                              note: notes[index],
                            ),
                          ),
                        );

                        // Update the note in the list if edited
                        if (updatedNote != null) {
                          setState(() => notes[index] = updatedNote);
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
