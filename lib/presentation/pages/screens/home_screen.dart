import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sizendoapp/data/models/post.dart';
import 'package:sizendoapp/data/services/post_service.dart';
import 'package:sizendoapp/presentation/widgets/post_card.dart';
import 'add_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<PostModel>> futurePosts;
  String? paket;
  String? status;

  @override
  void initState() {
    super.initState();
    loadUserData();
    futurePosts = PostService.fetchPosts();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('user_email');

    if (email != null) {
      final url = Uri.parse('https://siberzendo.com/api_login.php');
      final response = await http.post(url, body: {'email': email});

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success']) {
          setState(() {
            paket = jsonData['data']['paket'];
            status = jsonData['data']['status'];
          });
        }
      }
    }
  }

  bool get canPost {
    if (status?.toLowerCase() != 'active') return false;
    final lowerPaket = paket?.toLowerCase();
    return lowerPaket == 'aktivis' || lowerPaket == 'netizen' || lowerPaket == 'inisiator';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIZENDO', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          if (canPost)
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddPostScreen()),
                ).then((_) {
                  setState(() {
                    futurePosts = PostService.fetchPosts(); // Refresh data
                  });
                });
              },
            ),
        ],
      ),
      body: FutureBuilder<List<PostModel>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada postingan'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final post = snapshot.data![index];
                return PostCard(
                  username: post.username,
                  content: post.content,
                  imageUrls: post.image != null ? [post.image!] : [],
                );
              },
            );
          }
        },
      ),
    );
  }
}
