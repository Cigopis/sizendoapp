import 'package:flutter/material.dart';

class FirstIntroPage extends StatelessWidget {
  const FirstIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            const SizedBox(height: 24),
            const Text(
              'Apa sebenarnya\nplatform ini?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C2FDE), // Warna biru seperti di gambar
              ),
            ),
            const SizedBox(height: 24),
            Image.asset(
              'assets/images/question_illustration.png',
              height: 300,
            ),
            const SizedBox(height: 24),
            const Text(
              'SIZENDO (Siber & Netizen Indonesia) adalah organisasi warganet yang lahir di Kota Pahlawan, Surabaya—kota metropolitan terbesar kedua setelah Jakarta. Sebagai pusat urbanisasi dan teknologi, Surabaya menjadi tolak ukur perilaku warganet dan perkembangan dunia digital di Indonesia.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
