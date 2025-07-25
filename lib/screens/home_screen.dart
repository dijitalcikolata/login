import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String adSoyad = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        setState(() {
          adSoyad = userDoc['adSoyad'] ?? '';
          email = userDoc['email'] ?? '';
        });
      }
    } catch (e) {
      debugPrint("Hata: $e");
    }
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  void _navigateTo(String routeName) {
    Navigator.pop(context); // menüyü kapat
    Navigator.pushNamed(context, routeName); // hedefe git
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(adSoyad),
              accountEmail: Text(email),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: Colors.blueAccent),
              ),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Ana Sayfa"),
              onTap: () => _navigateTo('/home'),
            ),
            ListTile(
              leading: const Icon(Icons.directions_boat),
              title: const Text("Eğitim Programı"),
              onTap: () => _navigateTo('/egitim'),
            ),
            ListTile(
              leading: const Icon(Icons.event),
              title: const Text("Etkinlik Takvimi"),
              onTap: () => _navigateTo('/etkinlik'),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text("Hakkımızda"),
              onTap: () => _navigateTo('/hakkimizda'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ayarlar'),
              onTap: () => Navigator.pushNamed(context, '/ayarlar'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text("Çıkış Yap"),
              onTap: _signOut,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("AKSAZ YELKEN"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: adSoyad.isEmpty
            ? const CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person, size: 72, color: Colors.indigo),
                  const SizedBox(height: 16),
                  Text(
                    "Hoş geldin, $adSoyad 👋",
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Email: $email",
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}