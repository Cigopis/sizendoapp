import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sizendoapp/data/models/member.dart';

class ProfileScreen extends StatefulWidget {
  final String userEmail;

  const ProfileScreen({super.key, required this.userEmail});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Member? member;

  Future<void> fetchMember() async {
    final response = await http.get(
      Uri.parse("http://localhost/sizendo_api/get_profile.php?email=${widget.userEmail}"),
    );

    if (response.statusCode == 200) {
      setState(() {
        member = Member.fromJson(json.decode(response.body));
      });
    } else {
      throw Exception("Gagal mengambil data profil");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMember();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF110EC6),
      body: member == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Selamat Pagi", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          Text(member!.nama, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Text("@${member!.email.split('@')[0]}", style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Membership", style: TextStyle(color: Colors.white70)),
                      Text(member!.paket, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 8),
                      const Text("Aktif s/d 11/04/2024", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Tambahkan tombol, kotak Tersimpan, Teman, dll sesuai desain kamu
              ],
            ),
    );
  }
}
