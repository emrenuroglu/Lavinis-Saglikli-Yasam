import 'package:flutter/material.dart';

Widget customDropdownButton({
  required BuildContext context,
  required int? value,
  required List<String> items,
  required ValueChanged<int?> onChanged,
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: DropdownButtonFormField<int>(
        value: value,
        onChanged: onChanged,
        items: List.generate(items.length, (index) {
          return DropdownMenuItem<int>(
            value: index,
            child: Text(
              items[index],
              style: const TextStyle(color: Colors.black),
            ),
          );
        }),
        decoration: const InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          fillColor: Color(0xff282C34),
          filled: false,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    ),
  );
}
