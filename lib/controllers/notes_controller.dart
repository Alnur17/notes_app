import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotesController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> notes = [];
  bool isLoading = false;

  @override
  void onInit() {
    fetchNotes();
    super.onInit();
  }

  Future<void> fetchNotes() async {
    try {
      isLoading = true;
      update();

      var notesData = await firestore.collection('notes').get();
      notes = notesData.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> addNote(String title, String description) async {
    try {
      isLoading = true;
      update();

      await firestore.collection('notes').add({
        'title': title,
        'description': description,
        'created_at': DateTime.now(),
      });

      fetchNotes();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      isLoading = true;
      update();

      await firestore.collection('notes').doc(noteId).delete();

      fetchNotes();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
