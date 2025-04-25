import 'package:flutter/material.dart';

class EgitmenContainer extends StatelessWidget {
  final String asset;
  final String name; 
  final String detail1;
  final String detail2;
  const EgitmenContainer({super.key, required this.asset, required this.name, required this.detail1, required this.detail2});

  @override
  Widget build(BuildContext context) {
    return     Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
              color: Colors.white, 
              borderRadius: BorderRadius.circular(15)
                ),
                height: 400,
                width: double.infinity, 
  
                child: Column( 
                  children: [ 
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container( 
                        width: 200, 
                        height: 200,
                        decoration:   BoxDecoration( 
                          shape: BoxShape.circle,
                          image: DecorationImage(image:  AssetImage(asset), 
                          )
                        ),
                      ),
                    ), 
                    Text(name,style: TextStyle(color: Colors.purple.shade600,fontSize: 24),) , 
                      Column(
                        children: [
                           Text(detail1,style: const TextStyle(color: Colors.black,fontSize: 18),), 
                             Text(detail2,style: const TextStyle(color: Colors.black,fontSize: 18),),
                        ],
                      ), 
                      Padding(
                        padding: const EdgeInsets.only(top: 40,right: 70,left: 70),
                        child: Container(
                          decoration: BoxDecoration( 
                            borderRadius: BorderRadius.circular(20), 
                              color: Colors.purple.shade600,
                          ),
                        
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Row( 
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [ 
                                Icon(Icons.calendar_month_rounded,color: Colors.white,), 
                                Text("RANDEVU AL",style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
            );
  }
}