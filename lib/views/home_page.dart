import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lavinis/widget/drawer_menu.dart';
import 'package:lavinis/widget/hizmetler_widgets/hizmetler_home_buildstream.dart';
import 'package:lavinis/widget/blog_widgets/blog_home_buildstream.dart'; // BlogScreen eklendi

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: const Text("Ana Sayfa"),
        centerTitle: true,
      ),
      drawer: const Drawer(
        child: Column(
          children: [MenuHeader(), MenuItems()],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      image: const DecorationImage(
                          image: AssetImage("assets/home_container.jpg"),
                          fit: BoxFit.fill)),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Kendine Bir İyilik Yap",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        TypingText(),
                      ],
                    ),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Hizmetlerimiz",
              style: TextStyle(
                  color: Colors.purple.shade600,
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                textAlign: TextAlign.center,
                "LAVİNİS Egzersiz ve Danışmanlık Merkezi olarak danışanlarımızın yaşam kalitesini artırmak ve onlara ağrısız bir yaşam sunmak için profesyonel bir çatı altında 2020 yılında hizmet hayatına başladık.\nLAVİNİS bünyesinde; Reformer Pilates, Hamile Pilatesi, Yogaterapi, Manuel Terapi, Pelvik Taban Rehabilitasyonu, 3 Boyutlu Skolyoz Egzersizleri, Lenfödem Rehabilitasyonu, Kanser Sonrası Egzersiz Danışmanlığı, Dans ve Zumba hizmetlerini vermekteyiz.",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const HizmetStream(),
            const SizedBox(
              height: 400, // Sabit bir yükseklik belirledik
              child:  BlogPostScreen(),// BlogPostScreen widget'ını ekledik
            ),
          ],
        ),
      ),
    );
  }
}

class TypingText extends StatefulWidget {
  const TypingText({super.key});

  @override
  _TypingTextState createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  final List<String> _texts = [
    "Hayat Kaliteni Yükselt",
    "Ağrılarından Kurtul",
    "Bedenini Harakete Geçir",
  ];
  int _currentIndex = 0;
  String _displayedText = "";
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTextRotation();
  }

  void _startTextRotation() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return; // Eğer widget hala ağaçta değilse setState çağırılmaz
      setState(() {
        _currentIndex = (_currentIndex + 1) % _texts.length;
        _displayedText = "";
      });
      _showTextWithTypingEffect(_texts[_currentIndex]);
    });
  }

  Future<void> _showTextWithTypingEffect(String text) async {
    for (int i = 0; i < text.length; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted) return; // Eğer widget hala ağaçta değilse setState çağırılmaz
      setState(() {
        _displayedText += text[i];
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Timer iptal edilir
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: const TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
