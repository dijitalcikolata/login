import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 🔑 Oturum kontrolü için
import 'package:login/sayfalar/ayarlar_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'package:login/screens/register_screen.dart';


import 'package:login/sayfalar/egitim_screen.dart';
import 'package:login/sayfalar/etkinlik_screen.dart';
import 'package:login/sayfalar/hakkimizda_screen.dart';
// Diğer importların yanında yer alsın





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // 🔥 Firebase başlatılıyor
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔍 Giriş yapmış kullanıcı varsa buradan tespit ediliyor
    final currentUser = FirebaseAuth.instance.currentUser;

    return MaterialApp(
      title: 'Yelken Kayıt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.deepPurple.shade50,
        primarySwatch: Colors.deepPurple,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.deepPurple,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      // 🧠 Oturum varsa doğrudan home'a yönlen
      initialRoute: currentUser == null ? '/login' : '/home',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/egitim': (context) => const EgitimScreen(),
        '/etkinlik': (context) => const EtkinlikScreen(),
        '/hakkimizda': (context) => const HakkimizdaScreen(),
        '/anasayfa': (context) => const HomeScreen(),
        '/ayarlar': (context) => const AyarlarScreen(),
      },
    );
  }
}