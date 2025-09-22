import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:galleria_app/screens/onboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // No firebase_options.dart needed

  final prefs = await SharedPreferences.getInstance();
  final bool seenOnboard = prefs.getBool('seenOnboard') ?? false;

  runApp(MyApp(seenOnboard: seenOnboard));
}

class MyApp extends StatelessWidget {
  final bool seenOnboard;
  const MyApp({super.key, required this.seenOnboard});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Galleria App',
      initialRoute: seenOnboard ? '/login' : '/onboard',
      routes: {
        '/onboard': (context) => OnboardScreen(
              onComplete: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('seenOnboard', true);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
