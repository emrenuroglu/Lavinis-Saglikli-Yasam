import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogGuncellemeSayfasi extends StatefulWidget {
  final DocumentSnapshot blogPost;

  const BlogGuncellemeSayfasi(this.blogPost, {super.key});

  @override
  _BlogGuncellemeSayfasiState createState() => _BlogGuncellemeSayfasiState();
}

class _BlogGuncellemeSayfasiState extends State<BlogGuncellemeSayfasi> {
  late List<TextEditingController> _headingControllers;
  late List<TextEditingController> _contentControllers;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Başlık ve içerik için TextEditingController oluşturma
    var sections = widget.blogPost['sections'] as List<dynamic>? ?? [];
    _headingControllers = List.generate(
      sections.length,
      (index) => TextEditingController(text: sections[index]['heading'] ?? ''),
    );
    _contentControllers = List.generate(
      sections.length,
      (index) => TextEditingController(text: sections[index]['content'] ?? ''),
    );
  }

  @override
  void dispose() {
    // TextEditingController'ları serbest bırakma
    _headingControllers.forEach((controller) => controller.dispose());
    _contentControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> _updateBlogPost() async {
    var sections = widget.blogPost['sections'] as List<dynamic>? ?? [];
    List<Map<String, String>> updatedSections = [];
    
    for (int i = 0; i < sections.length; i++) {
      updatedSections.add({
        'heading': _headingControllers[i].text,
        'content': _contentControllers[i].text,
      });
    }

    try {
      await FirebaseFirestore.instance.collection('blogPosts').doc(widget.blogPost.id).update({
        'title': widget.blogPost['title'], // Başlık değişmedi
        'sections': updatedSections,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Blog Yazısı Güncellendi')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Güncelleme sırasında hata oluştu: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var sections = widget.blogPost['sections'] as List<dynamic>? ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Yazısını Düzenle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _updateBlogPost,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView.builder(
            itemCount: sections.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'baslık ${index + 1}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade600,
                      ),
                    ),
                    TextFormField(
                      controller: _headingControllers[index],
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        labelText: 'Başlık ${index + 1}',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Başlık boş olamaz';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _contentControllers[index],
                      maxLines: 10,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        labelText: 'İçerik ${index + 1}',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'İçerik boş olamaz';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
