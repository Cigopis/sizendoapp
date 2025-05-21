import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizendoapp/data/models/member.dart';
import 'package:sizendoapp/presentation/pages/screens/edit_profile_screen.dart';
import 'package:sizendoapp/presentation/pages/screens/help_center_screen.dart';
import 'package:sizendoapp/presentation/widgets/membership_card.dart';
class ProfileScreen extends StatefulWidget {
  final String userEmail;

  const ProfileScreen({super.key, required this.userEmail});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Member? member;

  @override
  void initState() {
    super.initState();
    fetchMemberData();
  }

  Future<void> fetchMemberData() async {
  final url = Uri.parse('https://siberzendo.com/api_login.php');
  final response = await http.post(url, body: {'email': widget.userEmail});

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    if (jsonData['success']) {
      final data = jsonData['data'];
      final memberData = data is List ? data.first : data;

      setState(() {
        member = Member.fromJson(memberData);
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', widget.userEmail);
    } else {
      setState(() {
        member = Member(
          id: '',
          orderId: '',
          nama: "Gagal memuat data",
          email: widget.userEmail,
          paket: "paket tidak tersedia",
          total: '',
          noWa: '',
          sosmed: '',
          catatan: '',
          status: "inactive",
          createdAt: '',
          updatedAt: '',
          isActive: '',
          startDate: '',
          endDate: '',
        );
      });
    }
  } else {
    setState(() {
      member = Member(
        id: '',
        orderId: '',
        nama: "Error koneksi",
        email: widget.userEmail,
        paket: "paket tidak tersedia",
        total: '',
        noWa: '',
        sosmed: '',
        catatan: '',
        status: "inactive",
        createdAt: '',
        updatedAt: '',
        isActive: '',
        startDate: '',
        endDate: '',
      );
    });
  }
}

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_email');
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Future<void> confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah kamu yakin ingin keluar akun?'),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Tidak')),
            TextButton(onPressed: () => Navigator.of(context).pop(true), child: const Text('Ya')),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await logout(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryBlue = const Color(0xFF0D0D8D);

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
                      member?.nama ?? 'Loading...',
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        member != null ? "@${member!.email.split('@').first}" : '',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
                  ),
                  child: ListView(
                    children: [
                      const SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          menuButton(
                            icon: Icons.person,
                            label: "Ubah Profile",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => EditProfileScreen(email: widget.userEmail)),
                              ).then((_) => fetchMemberData());
                            },
                          ),
                          menuButton(icon: Icons.lock, label: "Ganti Password"),
                          menuButton(
                            icon: Icons.help_outline,
                            label: "Pusat Bantuan",
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpCenterScreen()));
                            },
                          ),
                          menuButton(
                            icon: Icons.logout,
                            label: "Keluar Akun",
                            iconColor: Colors.red,
                            textColor: Colors.red,
                            onTap: () => confirmLogout(context),
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

          // Panggil widget MembershipCard yang sudah dibuat terpisah
          if (member != null) MembershipCard(member: member!),
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        splashColor: iconColor.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(height: 4),
              Text(label, style: TextStyle(fontSize: 9, color: textColor)),
            ],
          ),
        ),
      ),
    );
  }

  Widget featureButton({required IconData icon, required String label}) {
    return Container(
      width: 140,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D8D),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2))],
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
