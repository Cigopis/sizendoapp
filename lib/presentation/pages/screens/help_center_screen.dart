import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // opsional
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(), 
            Expanded(
              flex: 12, // atur sesuai kebutuhan (besar konten)
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  HelpItem(
                    question: "Bagaimana cara mengubah profil?",
                    answer:
                        "Masuk ke halaman profil, lalu klik tombol 'Ubah Profil'.",
                  ),
                  HelpItem(
                    question: "Bagaimana cara mengganti password?",
                    answer:
                        "Fitur ganti password akan segera tersedia di pembaruan berikutnya.",
                  ),
                  HelpItem(
                    question: "Kenapa saya tidak bisa login?",
                    answer:
                        "Pastikan email dan password Anda benar. Jika masih bermasalah, hubungi admin.",
                  ),
                  HelpItem(
                    question: "Bagaimana cara upgrade paket?",
                    answer:
                        "Silakan hubungi tim layanan kami melalui email untuk informasi lebih lanjut.",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HelpItem extends StatelessWidget {
  final String question;
  final String answer;

  const HelpItem({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              answer,
              style: const TextStyle(
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
