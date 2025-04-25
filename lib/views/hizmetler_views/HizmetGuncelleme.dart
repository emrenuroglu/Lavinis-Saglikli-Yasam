import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HizmetGuncelleme extends StatefulWidget {
  const HizmetGuncelleme({super.key, required this.doc});
  final QueryDocumentSnapshot doc;

  @override
  State<HizmetGuncelleme> createState() => _HizmetGuncellemeState();
}

class _HizmetGuncellemeState extends State<HizmetGuncelleme> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _detail1Controller;
  late TextEditingController _detail2Controller;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.doc["baslik"]);
    _detail1Controller = TextEditingController(text: widget.doc["detay1"]);
    _detail2Controller = TextEditingController(text: widget.doc["detay2"]);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detail1Controller.dispose();
    _detail2Controller.dispose();
    super.dispose();
  }

  Future<void> _updateData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('hizmetler')
            .doc(widget.doc.id)
            .update({
          'baslik': _titleController.text,
          'detay1': _detail1Controller.text,
          'detay2': _detail2Controller.text,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veri güncellendi')),
        );

        Navigator.pop(context); // Go back to the previous screen
      } catch (e) {
        print("Güncelleme sırasında hata: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Güncelleme sırasında hata oluştu')),
        );
      }
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Hizmet Güncelle'),
      backgroundColor: Colors.grey.shade200,
      elevation: 0,
    ),
    backgroundColor: Colors.grey.shade200,
    body: SingleChildScrollView( // Burayı ekledik
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Başlık',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade600,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                labelText: 'Başlık',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Başlık boş olamaz';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Detay 1',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade600,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _detail1Controller,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                labelText: 'Detay 1',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Detay 1 boş olamaz';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Detay 2',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple.shade600,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _detail2Controller,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                labelText: 'Detay 2',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Detay 2 boş olamaz';
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: _updateData,
                style: ElevatedButton.styleFrom(
                 iconColor : Colors.purple.shade600,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Güncelle'),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
}