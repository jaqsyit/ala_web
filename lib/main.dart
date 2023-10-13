import 'package:ala_web/firebase_options.dart';
import 'package:ala_web/kezek_add_screen.dart';
import 'package:ala_web/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auto Light Anuar',
      // home: KezekCarAddScreen(count: 5),
      home: LandingScreen(),
    );
  }
}
