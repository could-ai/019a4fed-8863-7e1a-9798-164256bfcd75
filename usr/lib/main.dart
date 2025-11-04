import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/loan_application_screen.dart';
import 'screens/loan_calculator_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const LoanApp());
}

class LoanApp extends StatelessWidget {
  const LoanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/apply': (context) => const LoanApplicationScreen(),
        '/calculator': (context) => const LoanCalculatorScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}