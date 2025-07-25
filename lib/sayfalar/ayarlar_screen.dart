import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/main_scaffold.dart';

class AyarlarScreen extends StatefulWidget {
  const AyarlarScreen({super.key});

  @override
  State<AyarlarScreen> createState() => _AyarlarScreenState();
}

class _AyarlarScreenState extends State<AyarlarScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController adSoyadController = TextEditingController();
  final TextEditingController telefonController = TextEditingController();
  String? yuzmeDurumu;
  String? kanGrubu;
  String? profilFotoUrl;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      adSoyadController.text = data["adSoyad"] ?? "";
      telefonController.text = data["telefon"] ?? "";
      yuzmeDurumu = data["yuzmeDurumu"] ?? "Bilmiyor";
      kanGrubu = data["kanGrubu"] ?? "A Rh(+)";
      profilFotoUrl = data["profilFotoUrl"];
      setState(() {});
    }
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "adSoyad": adSoyadController.text.trim(),
        "telefon": telefonController.text.trim(),
        "yuzmeDurumu": yuzmeDurumu,
        "kanGrubu": kanGrubu,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bilgiler güncellendi")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: "Ayarlar",
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (profilFotoUrl != null)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(profilFotoUrl!),
                ),
              const SizedBox(height: 16),
              TextFormField(
                controller: adSoyadController,
                decoration: const InputDecoration(labelText: "Ad Soyad"),
                validator: (value) =>
                value!.isEmpty ? "Ad soyad boş bırakılamaz" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: telefonController,
                decoration: const InputDecoration(labelText: "Telefon"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.length != 11
                    ? "Telefon 11 haneli olmalı"
                    : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: yuzmeDurumu,
                decoration: const InputDecoration(labelText: "Yüzme Durumu"),
                items: const [
                  DropdownMenuItem(value: "Biliyor", child: Text("Biliyor")),
                  DropdownMenuItem(value: "Bilmiyor", child: Text("Bilmiyor")),
                ],
                onChanged: (val) => setState(() => yuzmeDurumu = val),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: kanGrubu,
                decoration: const InputDecoration(labelText: "Kan Grubu"),
                items: const [
                  DropdownMenuItem(value: "A Rh(+)", child: Text("A Rh(+)")),
                  DropdownMenuItem(value: "A Rh(-)", child: Text("A Rh(-)")),
                  DropdownMenuItem(value: "B Rh(+)", child: Text("B Rh(+)")),
                  DropdownMenuItem(value: "B Rh(-)", child: Text("B Rh(-)")),
                  DropdownMenuItem(value: "0 Rh(+)", child: Text("0 Rh(+)")),
                  DropdownMenuItem(value: "0 Rh(-)", child: Text("0 Rh(-)")),
                  DropdownMenuItem(value: "AB Rh(+)", child: Text("AB Rh(+)")),
                  DropdownMenuItem(value: "AB Rh(-)", child: Text("AB Rh(-)")),
                ],
                onChanged: (val) => setState(() => kanGrubu = val),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _saveChanges,
                icon: const Icon(Icons.save),
                label: const Text("Güncelle"),
              )
            ],
          ),
        ),
      ),
    );
  }
}