import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ThirdIntroPage extends StatelessWidget {
  const ThirdIntroPage({super.key});

  void _openWhatsApp(BuildContext context) async {
  final phoneNumber = '+6285731599031'; // Ganti dengan nomor WA kamu
  final url = 'https://wa.me/$phoneNumber';
  
  try {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak dapat membuka WhatsApp.')),
      );
    }
  } catch (e) {
    debugPrint('Gagal membuka URL: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Terjadi kesalahan saat membuka WhatsApp.')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            const SizedBox(height: 24),
            const Text(
              'Jadilah bagian dari\nWarganet Cerdas!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C2FDE),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Bersama kita lawan hoaks, sebarkan informasi akurat,\ndan dukung Indonesia menuju era digital 2050.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            Image.asset(
              'assets/images/join_illustration.png',
              height: 300,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF1C2FDE)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Daftar sekarang',
                  style: TextStyle(
                    color: Color(0xFF1C2FDE),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Ini bagian TextSpan yang bisa ditekan
            Text.rich(
              TextSpan(
                text: 'Tanya kami ',
                style: const TextStyle(color: Colors.black54),
                children: [
                  TextSpan(
                    text: 'disini.',
                    style: const TextStyle(
                      color: Color(0xFF1C2FDE),
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()..onTap  = () => _openWhatsApp(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
