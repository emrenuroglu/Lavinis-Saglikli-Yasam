import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lavinis/views/blog_views/BlogGuncellemeSayfasi.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class BlogPostDetailScreen extends StatefulWidget {
  final DocumentSnapshot blogPost;

  const BlogPostDetailScreen(this.blogPost, {super.key});

  @override
  _BlogPostDetailScreenState createState() => _BlogPostDetailScreenState();
}

class _BlogPostDetailScreenState extends State<BlogPostDetailScreen> {
  final ItemScrollController _scrollController = ItemScrollController();
  late Future<bool> _isAdmin;

  @override
  void initState() {
    super.initState();
    _isAdmin = isUserAdmin(); // Admin olup olmadığını kontrol eden fonksiyonu çağır
  }

  Future<bool> isUserAdmin() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("Kullanıcılar")
          .doc(user.uid)
          .get();
      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
      return data?['isAdmin'] ?? false;
    } catch (e) {
      print("Admin kontrolü sırasında hata: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var sections = widget.blogPost['sections'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blogPost['title'] ?? 'Başlık Yok'),
        actions: [
          FutureBuilder<bool>(
            future: _isAdmin,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError || !snapshot.hasData || !snapshot.data!) {
                return Container(); // Admin değilse düzenleme butonunu göstermiyoruz
              }
              return IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogGuncellemeSayfasi(widget.blogPost),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // İçindekiler listesini gösteren bölge
          Container(
            width: 150,
            color: Colors.grey.shade200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "İçindekiler",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple.shade600,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: sections.length,
                    itemBuilder: (context, index) {
                      var section = sections[index];
                      return ListTile(
                        title: Text(
                          section['heading'] ?? 'Başlık Yok',
                          style: TextStyle(color: Colors.purple.shade600),
                        ),
                        onTap: () {
                          _scrollController.scrollTo(
                            index: index,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // İçeriğin gösterildiği bölge
          Expanded(
            child: ScrollablePositionedList.builder(
              itemScrollController: _scrollController,
              itemCount: sections.length,
              itemBuilder: (context, index) {
                var section = sections[index];
                return Padding(
                  key: ValueKey(section['id']),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section['heading'] ?? 'Başlık Yok',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(section['content'] ?? 'İçerik Yok'),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}