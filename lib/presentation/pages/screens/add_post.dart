import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  File? _imageFile;
  bool isLoading = false;

  // Memilih gambar dari galeri
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Mengirim postingan ke server
  Future<void> submitPost() async {
    if (_imageFile == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih gambar terlebih dahulu")),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final request = http.MultipartRequest(
        "POST",
        Uri.parse("https://siberzendo.com/add_post.php"),
      );
      request.fields['username'] = _usernameController.text;
      request.fields['content'] = _contentController.text;

      // Mengirim file gambar
      final imageFile = await http.MultipartFile.fromPath(
        'image',
        _imageFile!.path,
      );
      request.files.add(imageFile);

      final response = await request.send();

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      // Menangani respons dari server
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Post berhasil dikirim")),
        );
        Navigator.pop(context);  // Kembali ke layar sebelumnya
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal mengirim post")),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Postingan")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input Username
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
              const SizedBox(height: 10),
              // Input Content
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: "Isi Postingan"),
                maxLines: 4,
              ),
              const SizedBox(height: 10),
              // Tombol Pilih Gambar
              ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Pilih Gambar"),
              ),
              // Menampilkan gambar yang dipilih
              if (_imageFile != null) ...[
                const SizedBox(height: 10),
                Image.file(_imageFile!, height: 150),
              ],
              const SizedBox(height: 20),
              // Menampilkan tombol Kirim Postingan atau loading indicator
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: submitPost,
                        child: const Text("Kirim Postingan"),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
