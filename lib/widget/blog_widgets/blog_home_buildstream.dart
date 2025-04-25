
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lavinis/views/blog_views/blog_detail.dart';


class BlogPostScreen extends StatelessWidget {
  const BlogPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
         automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade200,
        title: Center(
          child: Text(
            'Blog Yazılarımız',
            style: TextStyle(
              color: Colors.purple.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('blogPosts').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var blogPosts = snapshot.data!.docs;
          return SizedBox(
            height: 300, // Liste yüksekliğini ayarla
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: blogPosts.length,
              itemBuilder: (context, index) {
                var blogPost = blogPosts[index];
                return Container(
                  width: 250, // Yatay liste öğe genişliği
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlogPostDetailScreen(blogPost),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(
                              "assets/${blogPost["image"]}.jpg",
                              width: 200,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            blogPost["title"],
                            style: TextStyle(
                              color: Colors.purple.shade600,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade600,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              "Daha Fazla Bilgi",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}





 





