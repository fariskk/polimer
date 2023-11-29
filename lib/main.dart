import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:polimer/features/language_selection/precentation/screens/language_selection_screen.dart';
import 'package:polimer/features/signup/precentation/screens/signup_screen.dart';
import 'package:polimer/features/spalsh_screeen/precentation/screens/splash_screen.dart';
import 'package:polimer/firebase_options.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupScreen(),
    );
  }
}
