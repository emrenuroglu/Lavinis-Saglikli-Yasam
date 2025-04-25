import 'package:flutter/material.dart';
import 'package:lavinis/widget/egitmen_container.dart';

class Egitmenler extends StatelessWidget {
  const Egitmenler({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(textAlign: TextAlign.center,
              "Eğitmen ve Terapistlerimiz",style: TextStyle(fontSize: 24,color: Colors.purple.shade600,fontWeight: FontWeight.bold),),
          ) , 
              const Text(textAlign: TextAlign.center,
            "Terapistlerimiz seçkin üniversitelerden mezun aynı zamanda bir çok sertifikasyon programından başarı ile geçmiş başarılı kişilerdir.",style: TextStyle(fontSize: 18,color: Colors.black),) , 
           const EgitmenContainer(asset: "assets/rabia.jpg", name: "Rabia Kevser Keleş", detail1: "Lavinis Merkezi Kurucusu", detail2: ""), 
           const EgitmenContainer(asset: "assets/sultan.jpg", name: "Sultan Demir", detail1: "Fizyoterapist ", detail2: "Skolyoz Terapisti"), 
           const EgitmenContainer(asset: "assets/aleyna.jpg", name: "Aleyna Akyıldız", detail1: "Fizyoterapist", detail2: "Manuel Terapist")
        ],
      ),
    );
  }
}

