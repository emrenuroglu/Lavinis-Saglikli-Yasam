import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lavinis/views/hizmetler_views/hizmet_detay.dart';
import 'package:lavinis/widget/hizmetler_widgets/hizmet_card.dart';

class HizmetPageStream extends StatelessWidget {
  const HizmetPageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        automaticallyImplyLeading:false,
        title: Center(
          child: Text(
            'Hizmetlerimiz',
            style: TextStyle(
              color: Colors.purple.shade600,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('hizmetler').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Hizmet Yok'));
          }

          // Grid düzeni
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Her satırda 2 öğe gösterecek
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.75, // Genişlik / yükseklik oranı
            ),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var hizmet = snapshot.data!.docs[index];
              return hizmetCard(
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HizmetDetay(hizmet),
                    ),
                  );
                },
                hizmet,
                context,
                () {},
              );
            },
          );
        },
      ),
    );
  }
}
