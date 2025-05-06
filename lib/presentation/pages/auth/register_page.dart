import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.help, color: Colors.red),
                  onPressed: () {
                    // bantuan
                  },
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Pendaftaran',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF000080),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Gunakan email aktif dan simpan informasi akun anda',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),

              // Nama Lengkap
              const Text(
                'Username',
                style: TextStyle(color: Color(0xFF000080)),
              ),
              const SizedBox(height: 8),
              _buildRoundedTextField(hintText: 'Nama Lengkap'),

              const SizedBox(height: 20),
              const Text(
                'E-mail',
                style: TextStyle(color: Color(0xFF000080)),
              ),
              const SizedBox(height: 8),
              _buildRoundedTextField(hintText: 'Email', inputType: TextInputType.emailAddress),

              const SizedBox(height: 20),
              const Text(
                'Password',
                style: TextStyle(color: Color(0xFF000080)),
              ),
              const SizedBox(height: 8),
              _buildRoundedTextField(hintText: 'Kata Sandi', obscureText: true),

              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // aksi daftar
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0000CC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Selanjutnya',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // login dengan Google
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/google_icon.png', height: 20),
                      const SizedBox(width: 8),
                      const Text('Sign in with Google'),
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

  // TextField bulat reusable
  Widget _buildRoundedTextField({
    required String hintText,
    bool obscureText = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextField(
      obscureText: obscureText,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF0000CC)),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF000080), width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
