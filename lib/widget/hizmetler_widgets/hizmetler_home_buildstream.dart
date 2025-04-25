import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lavinis/views/hizmetler_views/hizmet_detay.dart';
import 'package:lavinis/widget/hizmetler_widgets/hizmet_card.dart';

class HizmetStream extends StatefulWidget {
  const HizmetStream({super.key});

  @override
  State<HizmetStream> createState() => _HizmetStreamState();
}

class _HizmetStreamState extends State<HizmetStream> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("hizmetler").snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          debugPrint('Firestore Hatası: ${snapshot.error}');
          return Center(
            child: Text('Bir hata oluştu: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text("Hizmet Yok"),
          );
        }
        if (snapshot.hasData) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: snapshot.data!.docs.map((hizmet) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: hizmetCard(
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HizmetDetay(hizmet)));
                    },
                    hizmet,
                    context,
                    () {},
                  ),
                );
              }).toList(),
            ),
          );
        } else {
          return const Center(
            child: Text("Hizmet Yok"),
          );
        }
      },
    );
  }
}
