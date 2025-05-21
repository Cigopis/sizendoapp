import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProfileScreen extends StatefulWidget {
  final String email;

  const EditProfileScreen({super.key, required this.email});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController waController = TextEditingController();
  TextEditingController sosmedController = TextEditingController();
  TextEditingController catatanController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final response = await http.post(
      Uri.parse('https://siberzendo.com/api_login.php'),
      body: {'email': widget.email},
    );

    print("RESPON AMBIL PROFILE: ${response.body}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success']) {
        final user = data['data'];
        setState(() {
          namaController.text = user['nama_member'] ?? '';
          waController.text = user['no_wa'] ?? '';
          sosmedController.text = user['sosmed'] ?? '';
          catatanController.text = user['catatan'] ?? '';
        });
      }
    }
  }

  Future<void> updateProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final response = await http.post(
      Uri.parse('https://siberzendo.com/edit_profile.php'),
      body: {
        'email': widget.email,
        'nama_member': namaController.text,
        'no_wa': waController.text,
        'sosmed': sosmedController.text,
        'catatan': catatanController.text,
      },
    );

    setState(() => isLoading = false);

    print("RESPON UPDATE PROFILE: ${response.body}");

    try {
      final data = json.decode(response.body);
      if (data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil diperbarui')),
        );
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Gagal memperbarui profil')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal membaca respons server: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ubah Profil"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(28),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: namaController,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                  validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
                ),
                TextFormField(
                  controller: waController,
                  decoration: const InputDecoration(labelText: 'Nomor WhatsApp'),
                  validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
                ),
                TextFormField(
                  controller: sosmedController,
                  decoration: const InputDecoration(labelText: 'Sosial Media'),
                  validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
                ),
                TextFormField(
                  controller: catatanController,
                  decoration: const InputDecoration(labelText: 'Catatan'),
                  maxLines: 3,
                  validator: (val) => val!.isEmpty ? 'Wajib diisi' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : updateProfile,
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Simpan Perubahan"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
