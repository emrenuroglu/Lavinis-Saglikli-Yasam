import 'package:flutter/material.dart';


class InfoContainer extends StatelessWidget {
  final IconData? icon;
  final String titlee;
  final String details;
  const InfoContainer({super.key,required this.icon, required this.titlee, required this.details});

  @override
  Widget build(BuildContext context) {
    return    Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        icon,
                        color: Colors.green.shade900,
                        size: 55,
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                         titlee,
                          style: const TextStyle(color: Colors.black, fontSize: 24),
                        ),
                      ),
                       Text(
                        textAlign: TextAlign.center,
                       details,
                        style: const TextStyle(color: Colors.black, fontSize: 18),
                      )
                    ],
                  ),
                ),
              );
  }
}