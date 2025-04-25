import 'package:flutter/material.dart';
import 'package:lavinis/service/auth_service.dart';
import 'package:lavinis/views/blog_views/blog_page.dart';
import 'package:lavinis/views/hakkimizda.dart';
import 'package:lavinis/views/hizmetler_views/hizmet_page.dart';
import 'package:lavinis/views/home_page.dart';
import 'package:lavinis/views/randevu_al.dart';
import 'package:lavinis/views/randevu_list.dart';
import 'package:provider/provider.dart';

class MenuHeader extends StatelessWidget {
 
  const MenuHeader({super.key});



  @override
  Widget build(BuildContext context) { 

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Container( 
        height: 100,
        decoration: const BoxDecoration( 
          image: DecorationImage(image:  AssetImage("assets/logo.png"))
        ),
      )
    );
  }
}

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
      
        color: Colors.white,
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Ana Sayfa"),
              onTap: () { 
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage(),));
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu),
              title: const Text("Hizmetler"),
              onTap: () {
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HizmetPage(),));
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text("Blog"),
              onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BlogPage(),));
              },
            ), 
              ListTile(
              leading: const Icon(Icons.add),
              title: const Text("Randevu Al"),
              onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RandevuAl(),));
              },
            ),
            ListTile(
              leading: const Icon(Icons.view_agenda_outlined),
              title: const Text("Randevular"),
              onTap: () { 
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Randevuliste(),));
              },
            ),
              ListTile(
              leading: const Icon(Icons.supervised_user_circle_rounded),
              title: const Text("Hakkımızda"),
              onTap: () { 
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Hakkimizda(),));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout_sharp),
              title: const Text("Çıkış yap"),
              onTap: () { 
                    context.read<FlutterFireAuthService>().signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

