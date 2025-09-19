import 'package:flutter/material.dart';
import 'package:independent_absensi/shared_perfrence/shared_perfrence.dart';
import 'package:independent_absensi/views/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // cek login dari SharedPreferences
  final isLoggedIn = await PreferenceHandler.getLogin() ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absensi PPKD',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // kalau login true → langsung ke dashboard
      // kalau belum login → ke halaman login
      home: LoginScreen(),
    );
  }
}
