import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lavinis/widget/drawer_menu.dart';

class Randevuliste extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Randevuliste({super.key});

  Future<bool> isUserAdmin(String userId) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection("Kullanıcılar").doc(userId).get();
      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
      return data?['isAdmin'] ?? false;
    } catch (e) {
      print("Admin kontrolü sırasında hata: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: Column(
          children: [MenuHeader(), MenuItems()],
        ),
      ),
      appBar: AppBar(
        title: const Text('Randevular'),
      ),
      body: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Bir hata oluştu.'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Kullanıcı bulunamadı.'));
          }

          User user = snapshot.data!;

          return FutureBuilder<bool>(
            future: isUserAdmin(user.uid),
            builder: (context, adminSnapshot) {
              if (adminSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (adminSnapshot.hasError) {
                return const Center(child: Text('Bir hata oluştu.'));
              } else if (!adminSnapshot.hasData) {
                return const Center(child: Text('Admin bilgisi alınamadı.'));
              }

              bool isAdmin = adminSnapshot.data!;

              if (isAdmin == true) {
                return StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('Randevuler').snapshots(),
                  builder: (context, randevuSnapshot) {
                    if (randevuSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (randevuSnapshot.hasError) {
                      return const Center(child: Text('Bir hata oluştu.'));
                    } else if (!randevuSnapshot.hasData ||
                        randevuSnapshot.data == null) {
                      return const Center(child: Text('Randevu bulunamadı.'));
                    }

                    List<QueryDocumentSnapshot> randevular =
                        randevuSnapshot.data!.docs;

                    if (randevular.isEmpty) {
                      return const Center(
                          child: Text('Henüz randevu bulunmuyor.'));
                    }

                    return ListView.builder(
                      itemCount: randevular.length,
                      itemBuilder: (context, index) {
                        var appointment =
                            randevular[index].data() as Map<String, dynamic>;
                        return buildAppointmentCard(appointment);
                      },
                    );
                  },
                );
              } else {
                return FutureBuilder<DocumentSnapshot>(
                  future:
                      _firestore.collection('Kullanıcılar').doc(user.uid).get(),
                  builder: (context, userSnapshot) {
                    if (userSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (userSnapshot.hasError) {
                      return const Center(child: Text('Bir hata oluştu.'));
                    } else if (!userSnapshot.hasData ||
                        !userSnapshot.data!.exists) {
                      return const Center(
                          child: Text('Kullanıcı bilgileri bulunamadı.'));
                    }

                    var userDocument =
                        userSnapshot.data!.data() as Map<String, dynamic>;
                    List<dynamic> appointments = userDocument['Randevu'] ?? [];

                    if (appointments.isEmpty) {
                      return const Center(
                          child: Text('Henüz bir randevunuz yok.'));
                    }

                    return ListView.builder(
                      itemCount: appointments.length,
                      itemBuilder: (context, index) {
                        var appointment =
                            appointments[index] as Map<String, dynamic>;
                        return buildAppointmentCard(appointment);
                      },
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget buildAppointmentCard(Map<String, dynamic> appointment) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppointmentDetail(
              title: 'Tarih: ',
              value: appointment['tarihSaat'] ?? 'Bilinmeyen Tarih',
            ),
            const SizedBox(height: 10),
            buildAppointmentDetail(
              title: 'Ad Soyad: ',
              value: appointment['adSoyad'] ?? 'Bilinmeyen',
            ),
            const SizedBox(height: 10),
            buildAppointmentDetail(
              title: 'Telefon: ',
              value: appointment['telefonNumarasi'] ?? 'Bilinmeyen',
            ),
            const SizedBox(height: 10),
            buildAppointmentDetail(
              title: 'Terapi/Eğitim: ',
              value: appointment['terapiEgitim'] ?? 'Bilinmeyen',
            ),
            const SizedBox(height: 10),
            buildAppointmentDetail(
              title: 'Konum: ',
              value: appointment['konum'] ?? 'Bilinmeyen',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppointmentDetail(
      {required String title, required String value}) {
    return Text(
      '$title$value',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
