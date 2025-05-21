import 'package:flutter/material.dart';
import 'package:sizendoapp/presentation/pages/screens/profile_user.dart';

class PostCard extends StatefulWidget {
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
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  bool isSaved = false;
  bool showFullText = false;
  final int maxLines = 3;

  void _showImageFullScreen(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          backgroundColor: Colors.black,
          body: Center(
            child: InteractiveViewer(
              child: Image.network(imageUrl),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLongText = widget.content.length > 100;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero, 
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfileUser(emailOrUsername: widget.username),
                  ),
                );
              },
              child: Text(
                widget.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // agar terlihat bisa ditekan
                ),
              ),
),

            const SizedBox(height: 8),

            if (isLongText) ...[
              Text(
                widget.content,
                maxLines: showFullText ? null : maxLines,
                overflow: showFullText ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      showFullText = !showFullText;
                    });
                  },
                  child: Text(
                    showFullText ? "Lihat sedikit" : "Lihat selengkapnya",
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ]

              
            else
              Text(widget.content),

            if (widget.imageUrls.isNotEmpty) ...[
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => _showImageFullScreen(widget.imageUrls.first),
                child: Image.network(
                  widget.imageUrls.first,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],

            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: isSaved ? Colors.blue : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isSaved = !isSaved;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
