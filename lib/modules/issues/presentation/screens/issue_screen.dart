import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class IssueScreen extends StatelessWidget {
  const IssueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data - replace with your actual data
    final List<String> imageUrls = [
      'assets/images/issue1.jpg',
      'assets/images/issue2.jpg',
      'assets/images/issue3.jpg',
    ];
    
    final String category = 'Pothole';
    final String severity = 'High';
    final String location = 'Manassa Road';
    final int reportsCount = 3;
    
    final List<Comment> comments = [
      Comment(
        username: 'Peter',
        avatar: 'P',
        text: 'This deep pothole is causing damage to vehicles. Needs urgent repair!',
        timeAgo: '45 mins ago',
        likes: 1,
      ),
      Comment(
        username: 'Sarah',
        avatar: 'S',
        text: 'This pothole has been here for months. It\'s difficult to avoid while driving.',
        timeAgo: '2 hours ago',
        likes: 1,
      ),
      // Add more comments as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue Details'),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image carousel
          CarouselSlider(
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              autoPlay: false,
            ),
            items: imageUrls.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Text('Image not available'));
                      },
                    ),
                  );
                },
              );
            }).toList(),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category and Severity
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        category,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0B3954),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE5E5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        severity,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFF5252),
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 8),
                
                // Location
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Reports count
                Text(
                  '$reportsCount people reported this issue',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Comments section header
                const Text(
                  'Comments',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Comments list (scrollable)
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: comments.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final comment = comments[index];
                return CommentWidget(comment: comment);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Comment {
  final String username;
  final String avatar;
  final String text;
  final String timeAgo;
  final int likes;

  Comment({
    required this.username,
    required this.avatar,
    required this.text,
    required this.timeAgo,
    required this.likes,
  });
}

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            backgroundColor: const Color(0xFF0B3954),
            radius: 24,
            child: Text(
              comment.avatar,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          
          // Comment content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username and time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      comment.username,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0B3954),
                      ),
                    ),
                    Text(
                      comment.timeAgo,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                
                // Comment text
                Text(
                  comment.text,
                  style: const TextStyle(fontSize: 15),
                ),
                
                const SizedBox(height: 8),
                
                // Like counter
                Row(
                  children: [
                    const Icon(
                      Icons.favorite_border,
                      size: 20,
                      color: Color(0xFF0B3954),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${comment.likes}',
                      style: const TextStyle(
                        color: Color(0xFF0B3954),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // More options
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}