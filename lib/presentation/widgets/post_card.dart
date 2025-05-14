import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String content;
  final List<String> imageUrls;

  const PostCard({
    super.key,
    required this.username,
    required this.content,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(username, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content),
            if (imageUrls.isNotEmpty) ...[
              const SizedBox(height: 10),
              Image.network(imageUrls.first),
            ],
          ],
        ),
      ),
    );
  }
}
