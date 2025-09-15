import 'package:flutter/material.dart';

import 'login_screen.dart';
// import 'register_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3167EB),
      body: Stack(
        children: [
          // Background lengkung di bagian bawah
          Positioned.fill(
            child: ClipPath(
              clipper: BottomWaveClipper(),
              child: Container(color: const Color(0xFF5585F8)),
            ),
          ),

          // Konten utama
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 32),

                  // Ilustrasi
                  Center(
                    child: Image.asset(
                      'assets/images/onboarding.png',
                      height: 260,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Judul
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Absensi\nPPKD',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Tombol Masuk
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Masuk'),
                  ),

                  const SizedBox(height: 12),

                  // Tombol Register
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OnboardingScreen(),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Register'),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// CLIPPER UNTUK BACKGROUND LENGKUNG
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height * 0.65);

    var firstControlPoint = Offset(size.width / 2, size.height * 0.80);
    var firstEndPoint = Offset(size.width, size.height * 0.65);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
