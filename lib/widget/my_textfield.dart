import 'package:flutter/material.dart';
import 'package:lavinis/widget/randevu_text.dart';

Widget myTextField(
    TextEditingController controller, context, IconData icon, String title) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
     const SizedBox(height: 16,),
      customText(title),
      Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
            child: TextField(
              style: const TextStyle(color: Colors.black),
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  fillColor: const Color(0xff282C34),
                  suffixIcon: Icon(
                    icon,
                    color: Colors.purple.shade600,
                  )),
            ),
          ),
        ),
      ),
    ],
  );
}