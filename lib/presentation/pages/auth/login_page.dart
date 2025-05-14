import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sizendoapp/presentation/pages/screens/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  bool _isLoading = false;

  final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  // Mengecek status login pengguna ketika aplikasi dibuka
  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final userEmail = prefs.getString('user_email');
    
    if (userEmail != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Navbar(userEmail: userEmail)),
      );
    }
  }

  Future<void> login() async {
    final String email = emailController.text.trim();

    if (email.isEmpty || !emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan email yang valid')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2/sizendo_api/api_login.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'User-Agent': 'Mozilla/5.0',
        },
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        var body = response.body;
        if (body.isEmpty) throw Exception('Body kosong dari server');

        var data = json.decode(body);

        if (data['success'] == true) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_email', email);

          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login berhasil')),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Navbar(userEmail: email)),
          );
        } else {
          _showMessage(data['message'] ?? 'Login gagal');
        }
      } else {
        _showMessage('Gagal login. Kode status: ${response.statusCode}');
      }
    } on SocketException {
      _showMessage('Tidak ada koneksi internet');
    } on FormatException {
      _showMessage('Format respon tidak sesuai');
    } catch (e) {
      _showMessage('Terjadi kesalahan: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D8D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.topRight,
                child: Icon(Icons.help_outline, color: Colors.white),
              ),
              const SizedBox(height: 24),
              const Text(
                'Masuk',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Halo! Silakan masuk untuk mulai menggunakan aplikasi.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: _isLoading ? null : login,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Masuk',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
