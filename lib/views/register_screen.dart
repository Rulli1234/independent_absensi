// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController trainingController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isVisibility = false;
  bool _obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F68D4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Tombol Back
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),

              // Form Registrasi
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Registrasi Akun",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Nama
                      _buildTextField("Nama", namaController),
                      const SizedBox(height: 16),

                      // Email
                      _buildTextField("Email", emailController),
                      const SizedBox(height: 16),

                      // Training
                      _buildTextField("Training", trainingController),
                      const SizedBox(height: 16),

                      // Batch
                      _buildTextField("Batch Ke", batchController),
                      const SizedBox(height: 16),

                      // Password
                      TextFormField(
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Button Registrasi
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3F68D4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Registrasi Berhasil"),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Registrasi",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
