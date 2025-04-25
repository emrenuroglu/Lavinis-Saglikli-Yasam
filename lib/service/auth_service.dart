import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lavinis/views/home_page.dart';
import 'package:lavinis/views/login_page.dart';


class FlutterFireAuthService {
  final FirebaseAuth _firebaseauth;
  FlutterFireAuthService(this._firebaseauth);

  Stream<User?> get authStateChanges => _firebaseauth.idTokenChanges();

  Future passwordReset(String email,context) async {
    try {
      await _firebaseauth.sendPasswordResetEmail(email: email);
       showDialog(context: context, builder: (context){
        return const AlertDialog(
            content: Text("Sıfırlama Linki Gönderildi.E postanızı kontrol ediniz"),
         
        );
      });
         Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      debugPrint("$e");
      showDialog(context: context, builder: (context){
        return AlertDialog(
            content: Text(e.message.toString()),
        );
      });
    }
  }
  Future<bool> isUserAdmin(String userId) async {
  try {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection("Kullanıcılar")
        .doc(userId)
        .get();

    // DocumentSnapshot veri türünü kontrol edin
    if (userDoc.exists) {
      // Veriyi Map<String, dynamic> türüne çevirin
      Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;
      return data?['isAdmin'] ?? false; // Admin statüsünü döndürün
    } else {
      return false; // Belge bulunamazsa admin değil
    }
  } catch (e) {
    print("Admin kontrolü sırasında hata: $e");
    return false; // Hata durumunda admin değil
  }
}

  Future<String> signUp(String email, String password, String username,
    BuildContext context) async {
  try {
    UserCredential userCredential = await _firebaseauth
        .createUserWithEmailAndPassword(email: email, password: password);

    String userId = userCredential.user!.uid;

    await FirebaseFirestore.instance
        .collection("Kullanıcılar")
        .doc(userId)
        .set({
      "email": email,
      "Kullanıcı Adı": username,
      "Randevu": [],
      "isAdmin": false,  // Varsayılan olarak false
    });

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
    return "Success";
  } on FirebaseAuthException catch (e) {
    return e.message ?? "Bir hata oluştu";
  }
}

  Future<String> signIn(
    String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential = await _firebaseauth.signInWithEmailAndPassword(
        email: email, password: password);

    // Giriş yaptıktan sonra kullanıcıyı kontrol edin
    bool isAdminUser = await isUserAdmin(userCredential.user!.uid);

    if (isAdminUser) {
      // Admin kullanıcı ise
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Admin Girişi Yapıldı"),
          content: Text("Admin girişi başarılı!"),
          actions: [
            TextButton(
              onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(),));
                  },
              child: Text("Tamam"),
            ),
          ],
        ),
      );
    } else {
      // Normal kullanıcı ise
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Kullanıcıyı normal anasayfaya yönlendir
      );
    }

    return "Success";
  } on FirebaseAuthException catch (e) {
    showErrorDialog(context, "Giriş başarısız: ${e.message}");
    return e.message ?? "Bir hata oluştu";
  }
}


  Future<void> signOut(BuildContext context) async {
    await _firebaseauth.signOut().then((value) => {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoginPage()))
        });
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hata"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Tamam"),
            ),
          ],
        );
      },
    );
  }
}