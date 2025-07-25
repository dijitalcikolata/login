import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String adSoyad = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        if (userDoc.exists) {
          setState(() {
            adSoyad = userDoc['adSoyad'] ?? '';
            email = userDoc['email'] ?? '';
          });
        }
      }
    } catch (e) {
      debugPrint("Drawer kullanıcı bilgisi hatası: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(adSoyad.isEmpty ? 'Yükleniyor...' : adSoyad),
            accountEmail: Text(email.isEmpty ? '' : email),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.blueAccent),
            ),
            decoration: const BoxDecoration(color: Colors.blueAccent),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Ana Sayfa"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text("Eğitim"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/egitim');
            },
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text("Etkinlik"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/etkinlik');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("Hakkımızda"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/hakkimizda');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Çıkış Yap"),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}