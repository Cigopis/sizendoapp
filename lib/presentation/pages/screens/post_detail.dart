import 'package:flutter/material.dart';
import 'package:sizendoapp/data/models/post.dart';
import 'package:sizendoapp/presentation/widgets/post_card.dart';

class PostDetailScreen extends StatelessWidget {
  final PostModel post;

  const PostDetailScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.username)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: PostCard(
          username: post.username,
          content: post.content,
          imageUrls: post.image != null ? [post.image!] : [],
        ),
      ),
    );
  }
}
