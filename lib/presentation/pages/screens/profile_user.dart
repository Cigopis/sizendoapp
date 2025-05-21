import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileUser extends StatefulWidget {
  final String emailOrUsername;

  const ProfileUser({super.key, required this.emailOrUsername});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      final url = Uri.parse('https://siberzendo.com/api_login.php');
      final response = await http.post(url, body: {
        'email': widget.emailOrUsername.trim(), // Trim untuk menghindari spasi
      });

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success'] == true && jsonData['data'] != null) {
          setState(() {
            userData = jsonData['data'];
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = jsonData['message'] ?? 'Data tidak ditemukan.';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Terjadi kesalahan jaringan (${response.statusCode})';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Terjadi kesalahan: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profil')),
        body: Center(
          child: Text(errorMessage!, style: const TextStyle(color: Colors.red)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(userData?['nama_member'] ?? 'Profil')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _infoTile("👤 Nama", userData?['nama_member']),
            _infoTile("📧 Email", userData?['email']),
            _infoTile("📦 Paket", userData?['paket']),
            _infoTile("📱 No. WA", userData?['no_wa']),
            _infoTile("🔗 Sosmed", userData?['sosmed']),
            _infoTile("📝 Catatan", userData?['catatan']),
            _infoTile("✅ Status", userData?['status']),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        "$label : ${value ?? '-'}",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
