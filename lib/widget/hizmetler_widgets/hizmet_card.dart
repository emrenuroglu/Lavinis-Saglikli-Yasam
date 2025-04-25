import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';



Widget hizmetCard(
    Function()? ontap, QueryDocumentSnapshot doc, context, Function()? ontap2 ) {
  return GestureDetector(
    onTap: ontap,
    child:  Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(15), 
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                      child: SizedBox(
                         
                      
                        child: Image.asset("assets/${doc.data().toString().contains("image") ? doc.get("image") : ""}.jpg"),
                        
                      ),
                    ),
                    Text(  
                      textAlign: TextAlign.center,
                      doc.data().toString().contains("baslik")
                          ? doc.get("baslik")
                          : "",style: TextStyle(color: Colors.purple.shade600,fontSize: 18),), 
                    Container(
                      decoration: BoxDecoration( 
                        color: Colors.purple.shade600, 
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: const Padding(
                        padding:  EdgeInsets.all(5.0),
                        child: Text("Daha Fazla Bilgi",style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                ),
              ),
            )
  );
}