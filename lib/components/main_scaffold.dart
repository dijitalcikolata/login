import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  final String title;

  const MainScaffold({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueAccent, // ✅ MAVİ BAR BURADA!
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(color: Colors.blueAccent),
                accountName: const Text("dijital cikolata"),
                accountEmail: const Text("dijitalcikolata35@gmail.com"),
                currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Ana Sayfa'),
                onTap: () => Navigator.pushNamed(context, '/anasayfa'),
              ),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text('Eğitim'),
                onTap: () => Navigator.pushNamed(context, '/egitim'),
              ),
              ListTile(
                leading: const Icon(Icons.event),
                title: const Text('Etkinlik'),
                onTap: () => Navigator.pushNamed(context, '/etkinlik'),
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('Hakkımızda'),
                onTap: () => Navigator.pushNamed(context, '/hakkimizda'),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Ayarlar'),
                onTap: () => Navigator.pushNamed(context, '/ayarlar'),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Çıkış Yap'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),

            ],
          ),
        ),
      ),
      body: child,
    );
  }
}