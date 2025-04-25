import 'package:flutter/material.dart';
import 'package:lavinis/widget/blog_widgets/blog_page_buildstream.dart';
import 'package:lavinis/widget/drawer_menu.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(
        child: Column(
          children: [MenuHeader(), MenuItems()],
        ),
      ),
             backgroundColor: Colors.grey.shade200, 
      appBar: AppBar(
        title: const Text("Blog Sayfamız"), 
        centerTitle: true, 
        backgroundColor: Colors.grey.shade200,
      ),
      body: const BlogPageBuildStream(),
    );
  }
}