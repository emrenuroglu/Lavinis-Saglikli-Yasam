import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lavinis/const/hizmet_detay_const.dart';
import 'package:lavinis/views/egitmenler.dart';
import 'package:lavinis/views/hizmetler_views/HizmetGuncelleme.dart';
import 'package:lavinis/widget/info_container.dart';


class HizmetDetay extends StatefulWidget {
  const HizmetDetay(this.doc, {super.key});
  final QueryDocumentSnapshot doc;

  @override
  State<HizmetDetay> createState() => _HizmetDetayState();
}

class _HizmetDetayState extends State<HizmetDetay> {
  late Future<bool> _isAdmin;

  @override
  void initState() {
    super.initState();
    _isAdmin =
        isUserAdmin(); // Admin olup olmadığını kontrol eden fonksiyonu çağır
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
    String title = widget.doc["baslik"] ?? "Başlık Yok";
    String detail1 = widget.doc["detay1"] ?? "Detay Yok";
    String detail2 = widget.doc["detay2"] ?? "Detay Yok";
    String imageName = widget.doc["image"] ?? "default_image";

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.purple.shade600,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                detail1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                "$title Nedir?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.purple.shade600,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                detail2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                child: Image.asset("assets/${imageName}.jpg"),
              ),
              const SizedBox(height: 16),
              const InfoContainer(
                icon: Icons.message,
                titlee: HizmetDetayMetinleri.ozelProgramBaslik,
                details: HizmetDetayMetinleri.ozelProgramDetay,
              ),
              const SizedBox(height: 16),
              const InfoContainer(
                icon: Icons.energy_savings_leaf_sharp,
                titlee: HizmetDetayMetinleri.egzersizServislerimizBaslik,
                details: HizmetDetayMetinleri.egzersizServislerimizDetay,
              ),
              const SizedBox(height: 16),
              const InfoContainer(
                icon: Icons.supervised_user_circle_sharp,
                titlee: HizmetDetayMetinleri.tecrubeliTerapistlerBaslik,
                details: HizmetDetayMetinleri.tecrubeliTerapistlerDetay,
              ),
              const Egitmenler(),
              // Admin kontrolü
              FutureBuilder<bool>(
                future: _isAdmin,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError ||
                      !snapshot.hasData ||
                      !snapshot.data!) {
                    return Container(); // Admin değilse güncelleme butonunu göstermiyoruz
                  }
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HizmetGuncelleme(doc: widget.doc),
                        ),
                      );
                    },
                    child: const Text('Güncelle'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
