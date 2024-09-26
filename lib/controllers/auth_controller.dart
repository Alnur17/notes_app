import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isLoading = false;

  Future<void> login(String email, String password) async {
    try {
      isLoading = true;
      update();
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      isLoading = true;
      update();
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
      });
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    Get.offAllNamed('/login');
  }
}
