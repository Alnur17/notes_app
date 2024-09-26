import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/notes_controller.dart';

class AddNotePage extends StatelessWidget {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final NotesController notesController = Get.put(NotesController());

  AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Note")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<NotesController>(
          builder: (controller) {
            return Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Title"),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: "Description"),
                    minLines: 50,
                    maxLines: 50,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                const SizedBox(height: 20),
                controller.isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await notesController.addNote(
                              titleController.text,
                              descriptionController.text,
                            );
                            Get.back();
                          },
                          child: const Text("Add Note"),
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
