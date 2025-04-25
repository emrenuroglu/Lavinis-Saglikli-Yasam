import 'package:flutter/material.dart';

import 'package:lavinis/widget/drawer_menu.dart';
import 'package:lavinis/widget/hizmetler_widgets/hizmetler_page_buildstream.dart';

class HizmetPage extends StatefulWidget {
  const HizmetPage({super.key});

  @override
  State<HizmetPage> createState() => _HizmetPageState();
}

class _HizmetPageState extends State<HizmetPage> {
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
        title: const Text("Hizmetler Sayfamız"),
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
      ),
      body: const HizmetPageStream(),
    );
  }
}
