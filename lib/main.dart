import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/views/add_note_page.dart';
import 'package:notes_app/views/home_page.dart';
import 'package:notes_app/views/login_page.dart';
import 'package:notes_app/views/registration_page.dart';
import 'package:notes_app/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAy8SQU2fht5nfreqjOA0DDx8Omw87XGTk',
      appId: '1:694698990045:android:752e219e8f0f5aed6afe34',
      messagingSenderId: '694698990045',
      projectId: 'notes-app-7acc8',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegistrationPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/add_note', page: () => AddNotePage()),
      ],
    );
  }
}
