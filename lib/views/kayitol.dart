import 'package:flutter/material.dart';
import 'package:lavinis/service/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterPage({super.key});

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo.png', // 'assets' klasörüne eklediğiniz resim dosyasının adı
                  height: 150.0, // Resim yüksekliği
                ),
                const SizedBox(height: 30.0),
                Text(
                  'Kayıt Ol',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[900],
                  ),
                ),
                const SizedBox(height: 30.0),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    hintText: 'Kullanıcı Adı',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Şifre',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();
                    String username = _usernameController.text.trim();

                    if (email.isEmpty || password.isEmpty || username.isEmpty) {
                      showErrorDialog(context, "Lütfen tüm alanları doldurun.");
                    } else if (password.length < 6) {
                      showErrorDialog(
                          context, "Şifre en az 6 karakter olmalıdır.");
                    } else if (!email.endsWith("@gmail.com")) {
                      showErrorDialog(
                          context, "Email '@gmail.com' ile bitmelidir.");
                    } else {
                      context.read<FlutterFireAuthService>().signUp(
                            email,
                            password,
                            username,
                            context,
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Kayıt Ol',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                        context); // Kullanıcıyı geri login sayfasına yönlendirme
                  },
                  child: Text(
                    'Zaten hesabınız var mı? Giriş Yapın',
                    style: TextStyle(
                      color: Colors.blueGrey[700],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
