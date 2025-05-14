import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final String userEmail;

  const ProfileScreen({super.key, required this.userEmail});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String namaMember = "";
  String emailUser = "";

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final url = Uri.parse('https://siberzendo.com/api_login.php');
    final response = await http.post(url, body: {'email': widget.userEmail});

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['success']) {
        setState(() {
          namaMember = jsonData['data']['nama_member'] ?? "Tidak ada nama";
          emailUser = jsonData['data']['email'] ?? "Tidak ada email";
        });

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_email', widget.userEmail);
      } else {
        setState(() {
          namaMember = "Gagal memuat data";
          emailUser = "";
        });
      }
    } else {
      setState(() {
        namaMember = "Error koneksi";
        emailUser = "";
      });
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF0A0EFF);

    return Scaffold(
      backgroundColor: primaryBlue,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60, left: 24, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Selamat Pagi", style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 4),
                    Text(
                      namaMember.isNotEmpty ? namaMember : 'Loading...',
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "@${emailUser.split('@').first}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 20, left: 24, right: 24, bottom: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: ListView(
                    children: [
                      const SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          menuButton(icon: Icons.person, label: "Ubah Profile"),
                          menuButton(icon: Icons.lock, label: "Ganti Password"),
                          menuButton(icon: Icons.help_outline, label: "Pusat Bantuan"),
                          menuButton(
                            icon: Icons.logout,
                            label: "Keluar Akun",
                            iconColor: Colors.red,
                            textColor: Colors.red,
                            onTap: () => logout(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          featureButton(icon: Icons.bookmark, label: "Tersimpan"),
                          featureButton(icon: Icons.people, label: "Teman"),
                          featureButton(icon: Icons.event, label: "Acara"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            top: 185,
            right: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3)
                  )
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Membership", style: TextStyle(color: Colors.white70)),
                      SizedBox(height: 4),
                      Text("Basic", style: TextStyle(fontSize: 20, color: Colors.white)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Aktif s/d", style: TextStyle(color: Colors.white70)),
                      SizedBox(height: 4),
                      Text("11/04/2024", style: TextStyle(color: Colors.white)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget menuButton({
    required IconData icon,
    required String label,
    Color iconColor = Colors.black,
    Color textColor = Colors.black,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: iconColor),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 9, color: textColor)),
        ],
      ),
    );
  }

  Widget featureButton({required IconData icon, required String label}) {
    return Container(
      width: 140,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0EFF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))
        ],
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
