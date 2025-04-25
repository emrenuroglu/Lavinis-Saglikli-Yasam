import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lavinis/views/blog_views/blog_detail.dart';


class BlogPageBuildStream extends StatelessWidget {
  const BlogPageBuildStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        automaticallyImplyLeading: false,
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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Her satırda 2 öğe göster
                crossAxisSpacing: 8.0, // Satırlar arasındaki boşluk
                mainAxisSpacing: 8.0, // Sütunlar arasındaki boşluk
                childAspectRatio:
                    0.75, // Her bir öğenin genişlik/ yükseklik oranı
              ),
              itemCount: blogPosts.length,
              itemBuilder: (context, index) {
                var blogPost = blogPosts[index];
                return Card(
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
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          blogPost["title"],
                          style: TextStyle(
                            color: Colors.purple.shade600,
                            fontSize: 16,
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
                );
              },
            ),
          );
        },
      ),
    );
  }
}
