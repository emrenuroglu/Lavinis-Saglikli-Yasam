import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Service {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Randevu bilgilerini Firestore'a kaydetme fonksiyonu
  Future<void> saveAppointment({
    required User user,
    required String adSoyad,
    required String email,
    required String telefonNumarasi,
    required String konum,
    required String mesaj,
    required String terapiEgitim,
    required String tarihSaat,
  }) async {
    try {
     String userId = user.uid;
     FirebaseFirestore.instance.collection("Kullanıcılar").doc(userId).collection("Randevu");
     DocumentReference userDocument = FirebaseFirestore.instance.collection("Kullanıcılar").doc(userId);
     Map<String,dynamic> randevu = { 
      "adSoyad": adSoyad,
      "email": telefonNumarasi,
      "konum": konum,
      "mesaj": mesaj,
      "tarihSaat": tarihSaat,
      "telefonNumarasi": telefonNumarasi,
      "terapiEgitim": terapiEgitim,
     };
     await userDocument.update({
      "Randevu":FieldValue.arrayUnion([randevu])
     });
     await _firestore.collection('Randevuler').add({
        'kullaniciId': userId,
        'adSoyad': adSoyad,
        'email': email,
        'telefonNumarasi': telefonNumarasi,
        'konum': konum,
        'mesaj': mesaj,
        'terapiEgitim': terapiEgitim,
        'tarihSaat': tarihSaat,
      });
    } catch (e) {
      throw Exception('Randevu kaydedilemedi: $e');
    }
  }
}
