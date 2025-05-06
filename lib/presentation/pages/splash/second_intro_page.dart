import 'package:flutter/material.dart';

class SecondIntroPage extends StatelessWidget {
  const SecondIntroPage({super.key});

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF1C2FDE), // Warna biru khas
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            const SizedBox(height: 24),
            const Text(
              'Target Operation\nSIZENDO',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C2FDE),
              ),
            ),
            const SizedBox(height: 24),
            Image.asset(
              'assets/images/question_illustration.png', // ganti jika kamu punya ilustrasi yang beda
              height: 300,
            ),
            const SizedBox(height: 24),
            _buildBulletPoint(
              'Mengedukasi warganet tentang bahaya hoaks, ujaran kebencian, serta pemahaman yang tepat mengenai Undang-Undang Informasi dan Transaksi Elektronik (UU ITE).',
            ),
            _buildBulletPoint(
              'Berperan sebagai mitra pemerintah dalam mengawasi media sosial dan media siber yang tidak sesuai dengan fungsi dan tanggung jawabnya.',
            ),
            _buildBulletPoint(
              'Mendukung pemerintah dalam pengembangan teknologi informasi dan akselerasi digital, baik di dalam maupun luar negeri.',
            ),
            _buildBulletPoint(
              'Membangun komunitas besar warganet di seluruh Indonesia agar penyebaran informasi dapat dilakukan secara cepat, akurat, dan akuntabel, dengan tujuan mewujudkan Indonesia sebagai negara digital pada tahun 2050.',
            ),
          ],
        ),
      ),
    );
  }
}
