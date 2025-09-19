// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:independent_absensi/api/endpoint.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const id = "/register_screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false;

  // Dropdown Data
  List<dynamic> _trainings = [];
  List<dynamic> _batches = [];
  int? _selectedTrainingId;
  int? _selectedBatchId;
  String? _selectedGender;

  // Foto Profile
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _fetchTrainings();
    _fetchBatches();
  }

  Future<void> _fetchTrainings() async {
    try {
      final res = await http.get(Uri.parse(Endpoint.training));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          _trainings = data["data"] ?? [];
        });
      }
    } catch (e) {
      debugPrint("Error fetch training: $e");
    }
  }

  Future<void> _fetchBatches() async {
    try {
      final res = await http.get(Uri.parse(Endpoint.batch));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        setState(() {
          _batches = data["data"] ?? [];
        });
      }
    } catch (e) {
      debugPrint("Error fetch batch: $e");
    }
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  /// ✅ API Register
  Future<void> registerUser() async {
    if (_selectedTrainingId == null ||
        _selectedBatchId == null ||
        _selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua field dulu")),
      );
      return;
    }

    String? base64Image;
    if (_imageFile != null) {
      base64Image = base64Encode(await _imageFile!.readAsBytes());
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(Endpoint.register),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "nama": namaController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "training_id": _selectedTrainingId,
          "batch_id": _selectedBatchId,
          "gender": _selectedGender,
          "photo": base64Image, // kirim base64 ke API
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Registrasi berhasil")),
        );
        Navigator.pop(context); // balik ke login
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data["message"] ?? "Registrasi gagal")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Terjadi kesalahan: $e")));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF3F68D4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔙 Tombol Back
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),

              // 📝 Form Registrasi
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
                    children: [
                      const Text(
                        "Registrasi Akun",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 📷 Avatar di atas form
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: _imageFile != null
                              ? FileImage(_imageFile!)
                              : null,
                          child: _imageFile == null
                              ? const Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.white70,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Nama
                      _buildTextField("Nama", namaController),
                      const SizedBox(height: 16),

                      // Email
                      _buildTextField(
                        "Email",
                        emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      // 🔽 Dropdown Training
                      DropdownButtonFormField<int>(
                        isExpanded: true,
                        value: _selectedTrainingId,
                        items: _trainings.map<DropdownMenuItem<int>>((item) {
                          return DropdownMenuItem<int>(
                            value: item["id"],
                            child: Text(item["title"] ?? "Training"),
                          );
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => _selectedTrainingId = val),
                        decoration: _dropdownStyle("Pilih Training"),
                        validator: (value) =>
                            value == null ? "Training wajib dipilih" : null,
                      ),
                      const SizedBox(height: 16),

                      // 🔽 Dropdown Batch
                      DropdownButtonFormField<int>(
                        value: _selectedBatchId,
                        items: _batches.map<DropdownMenuItem<int>>((item) {
                          return DropdownMenuItem<int>(
                            value: item["id"],
                            child: Text("Batch ${item["batch_ke"]}"),
                          );
                        }).toList(),
                        onChanged: (val) =>
                            setState(() => _selectedBatchId = val),
                        decoration: _dropdownStyle("Pilih Batch"),
                        validator: (value) =>
                            value == null ? "Batch wajib dipilih" : null,
                      ),
                      const SizedBox(height: 16),

                      // 🔽 Dropdown Gender
                      DropdownButtonFormField<String>(
                        value: _selectedGender,
                        items: const [
                          DropdownMenuItem(
                            value: "L",
                            child: Text("Laki-laki"),
                          ),
                          DropdownMenuItem(
                            value: "P",
                            child: Text("Perempuan"),
                          ),
                        ],
                        onChanged: (val) =>
                            setState(() => _selectedGender = val),
                        decoration: _dropdownStyle("Pilih Gender"),
                        validator: (value) =>
                            value == null ? "Gender wajib dipilih" : null,
                      ),
                      const SizedBox(height: 16),

                      // 🔑 Password
                      TextFormField(
                        controller: passwordController,
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password tidak boleh kosong";
                          }
                          if (value.length < 6) {
                            return "Password minimal 6 karakter";
                          }
                          return null;
                        },
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

                      // 🚀 Button Registrasi
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
                          onPressed: _isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    registerUser();
                                  }
                                },
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Registrasi",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
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

  /// Reusable TextField Builder
  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$label tidak boleh kosong";
        }
        return null;
      },
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

  /// Style Dropdown
  InputDecoration _dropdownStyle(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.grey.shade200,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    );
  }
}
