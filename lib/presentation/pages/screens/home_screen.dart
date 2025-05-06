import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          'SIZENDO',
          style: TextStyle(
            color: Color(0xFF0D0D8D),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        actions: const [
          Icon(Icons.add, color: Colors.black87),
          SizedBox(width: 16),
          Icon(Icons.search, color: Colors.black87),
          SizedBox(width: 16),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: 5, // contoh 5 postingan
        itemBuilder: (context, index) {
          return const PostCard(
            username: "Daffa b",
            content:
                "Pentingnya siber di era sekarang memberikan tantangan bagi semua netizen, bijak dan berhati hati dalam menggunakan sosial media adalah kunci ",
          );
        },
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String username;
  final String content;

  const PostCard({
    super.key,
    required this.username,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 18, backgroundColor: Colors.grey),
              const SizedBox(width: 8),
              Text(
                username,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Icon(
                username == "Sizendo" ? Icons.verified_user : Icons.person_add_alt_1,
                color: username == "Sizendo" ? Colors.green : Colors.black54,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black87, fontSize: 14),
              children: [
                TextSpan(text: content),
                const TextSpan(
                  text: "Lihat selengkapnya",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(3, (index) {
              return Container(
                width: (MediaQuery.of(context).size.width - 60) / 2,
                height: 100,
                color: Colors.grey.shade300,
              );
            }),
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              Icon(Icons.favorite_border, size: 20),
              SizedBox(width: 4),
              Text("Suka"),
              SizedBox(width: 16),
              Icon(Icons.bookmark_border, size: 20),
              SizedBox(width: 4),
              Text("Simpan"),
            ],
          ),
        ],
      ),
    );
  }
}
