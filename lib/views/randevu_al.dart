import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lavinis/service/user_service.dart';
import 'package:lavinis/widget/custom_dropdown.dart';
import 'package:lavinis/widget/drawer_menu.dart';
import 'package:lavinis/widget/my_textfield.dart';
import 'package:lavinis/service/service.dart';
import 'package:provider/provider.dart'; // Service sınıfının import edilmesi

class RandevuAl extends StatefulWidget {
  const RandevuAl({super.key});

  @override
  State<RandevuAl> createState() => _RandevuAlState();
}

class _RandevuAlState extends State<RandevuAl> {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController nameSurname = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController message = TextEditingController();

  int? selectedIndex;
  final List<String> options = [
    'Reformer Plates',
    'Hamile Plates',
    'Yoga Terapi',
    'Manueş Terapi',
    'Pelvik Taban Rehabilitasyonu',
    '3 Boyutlu Skolyoz Egzersizleri',
    'Lenfödem Rehabilitasyonu',
    'Kanser Sonrası Egzersiz Danışmanlığı',
    'Dans ve Zumba',
  ];

  void updateSelectedIndex(int? index) {
    setState(() {
      selectedIndex = index;
      if (index != null) {
        typeController.text = options[index];
      }
    });
  }

  void _saveAppointment(User user) async {
    // Verileri kontrol et
    if (nameSurname.text.isEmpty ||
        email.text.isEmpty ||
        phoneNumber.text.isEmpty ||
        location.text.isEmpty ||
        message.text.isEmpty ||
        selectedIndex == null) {
      // Hatalı veya eksik veri varsa kullanıcıya uyarı göster
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: const Text('Lütfen tüm alanları doldurun.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
      return;
    }

    // Tarih ve saat bilgisini oluştur
    final String tarihSaat =
        '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}';

    try {
      // Service sınıfını kullanarak veriyi kaydet
      final service = Service();
      await service.saveAppointment(
        user: user,
        adSoyad: nameSurname.text,
        email: email.text,
        telefonNumarasi: phoneNumber.text,
        konum: location.text,
        mesaj: message.text,
        terapiEgitim: options[selectedIndex!],
        tarihSaat: tarihSaat,
      );

      // Başarı mesajı
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Başarı'),
          content: const Text('Randevunuz başarıyla alındı.'),
          actions: [
            TextButton(
              onPressed: () {
                // Tüm TextEditingController'ları temizle
                nameSurname.clear();
                email.clear();
                phoneNumber.clear();
                location.clear();
                message.clear();
                typeController.clear();
                setState(() {
                  selectedIndex = null;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Hata mesajı
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: Text('Randevu kaydedilemedi: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final currentUser = userProvider.currentUser;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: const Drawer(
        child: Column(
          children: [MenuHeader(), MenuItems()],
        ),
      ),
      appBar: AppBar(
        title: const Text("Randevu Al"),
        centerTitle: true,
        backgroundColor: Colors.grey.shade200,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              myTextField(nameSurname, context, Icons.supervised_user_circle,
                  "Adınız Soyadınız:"),
              myTextField(email, context, Icons.email, "Email:"),
              myTextField(
                  phoneNumber, context, Icons.phone, "Telefon Numaranız:"),
              myTextField(
                  location, context, Icons.location_on_sharp, "Location:"),
              myTextField(message, context, Icons.message, "Mesajınız"),
              const SizedBox(
                height: 16,
              ),
              Text('Terapi-Eğitim',
                  style: TextStyle(
                      color: Colors.purple.shade600,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
              customDropdownButton(
                context: context,
                value: selectedIndex,
                items: options,
                onChanged: updateSelectedIndex,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade600,
                  ),
                  onPressed: () {
                    _saveAppointment(currentUser!);
                  },
                  child: const Text("Randevu Al",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
