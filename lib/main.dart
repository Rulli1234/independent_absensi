import 'package:flutter/material.dart';
import 'package:independent_absensi/views/absensi/dashboard.dart';
import 'package:independent_absensi/views/auth/login_screen.dart';
import 'package:independent_absensi/views/auth/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Independent Absensi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: LoginScreen.id,
      routes: {
        "/login_screen": (context) => LoginScreen(),
        "/register_screen": (context) => const RegisterScreen(),
        "/dashboard_absen": (context) => const DashboardAbsen(),
      },
    );
  }
}
