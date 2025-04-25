import 'package:flutter/material.dart';
import 'package:lavinis/widget/drawer_menu.dart';


class Hakkimizda extends StatelessWidget {
  const Hakkimizda({super.key});

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
        title: const Text("Hakkımızda"),
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/logo.png"),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  "LAVİNİS Egzersiz ve Danışmanlık Merkezi olarak danı şanlarımızın ya şam kalitesini artırmak ve onlara a ğrısız bir ya şam sunmak için profesyonel bir çatı altında 2020 yılında hizmet hayatına başladık.\n LAVİNİS bünyesinde; Reformer Pilates, Hamile Pilatesi, Yogaterapi, Manuel Terapi, Pelvik Taban Rehabilitasyonu, 3 Boyutlu Skolyoz Egzersizleri, Lenfödem Rehabilitasyonu, Kanser Sonrası Egzersiz Danışmanlığı, Dans ve Zumba hizmetlerini vermekteyiz.",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 20,),
              Text("İletişim Bilgileri",
                  style: TextStyle(color: Colors.purple.shade600, fontWeight: FontWeight.w500, fontSize: 24),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Divider(color: Colors.black, height: 5),
              ),
              CustomInfoWidget(
                icon: Icon(Icons.location_on, color: Colors.purple.shade600),
                title: "Adres",
                content: "Yalıncak, Rize cad No:90/C 61000 Ortahisar/Trabzon",
              ),
              CustomInfoWidget(
                icon: Icon(Icons.email, color: Colors.purple.shade600),
                title: "Email",
                content: "info@lavinis.com",
              ),
                CustomInfoWidget(
                icon: Icon(Icons.phone, color: Colors.purple.shade600),
                title: "Telefon",
                content: "0531 331 15 17",
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class CustomInfoWidget extends StatelessWidget {
  final Icon icon;
  final String title;
  final String content;

  const CustomInfoWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            softWrap: true,
            overflow: TextOverflow.visible,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
