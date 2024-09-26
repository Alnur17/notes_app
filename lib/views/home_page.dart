import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/controllers/auth_controller.dart';
import '../controllers/notes_controller.dart';

class HomePage extends StatelessWidget {
  final NotesController notesController = Get.put(NotesController());
  final AuthController authController = Get.put(AuthController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text("Notes"),
        actions: [
          IconButton(
            onPressed: () => authController.logout(),
            style: IconButton.styleFrom(
              padding: const EdgeInsets.only(right: 12),
            ),
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      body: GetBuilder<NotesController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.notes.isEmpty) {
            return const Center(child: Text("No notes found."));
          }

          return SingleChildScrollView(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: controller.notes.length,
              itemBuilder: (context, index) {
                var note = controller.notes[index];
                return ListTile(
                  title: Text(note['title']),
                  subtitle: Text(note['description']),
                  trailing: IconButton(
                    onPressed: () =>
                        _showDeleteConfirmationDialog(context, note['id']),
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                    ),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add_note'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, String noteId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Note"),
          content: const Text("Are you sure you want to delete this note?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () {
                notesController.deleteNote(noteId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
