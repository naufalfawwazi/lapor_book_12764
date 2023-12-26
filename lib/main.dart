import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lapor_book_12764/firebase_options.dart';
import 'package:lapor_book_12764/pages/DashboardPage.dart';
import 'package:lapor_book_12764/pages/LoginPage.dart';
import 'package:lapor_book_12764/pages/RegisterPage.dart';
import 'package:lapor_book_12764/pages/SplashPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    title: 'Lapor Book',
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashPage(),
      '/login': (context) => LoginPage(),
      '/register': (context) => const RegisterPage(),
      '/dashboard': (context) => const DashboardPage(),
      // '/add': (context) => AddFormPage(),
      // '/detail': (context) => DetailPage(),
    },
  ));
}