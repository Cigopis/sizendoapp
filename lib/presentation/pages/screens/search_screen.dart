import 'package:flutter/material.dart';
import 'package:sizendoapp/data/models/post.dart';
import 'package:sizendoapp/data/services/post_service.dart';
import 'package:sizendoapp/presentation/pages/screens/post_detail.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<PostModel>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = PostService.fetchPosts();
    futurePosts.then((posts) {
      for (var post in posts) {
        print('Loaded image: ${post.image}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PostModel>>(
      future: futurePosts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Belum ada postingan'));
        }

        final postsWithImages = snapshot.data!
            .where((post) => post.image != null && post.image!.isNotEmpty)
            .toList();

        if (postsWithImages.isEmpty) {
          return const Center(child: Text('Tidak ada gambar untuk ditampilkan'));
        }

        return Column(
          children: [
            const SizedBox(height: 60), 
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: postsWithImages.length,
                itemBuilder: (context, index) {
                  final post = postsWithImages[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PostDetailScreen(post: post),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.grey[300],
                      child: Image.network(
                        post.image!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint('Failed to load image: ${post.image}, error: $error');
                          return const Icon(Icons.broken_image);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}