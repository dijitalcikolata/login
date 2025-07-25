import 'package:flutter/material.dart';
import '../components/main_scaffold.dart';

class HakkimizdaScreen extends StatelessWidget {
  const HakkimizdaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      title: "Hakkımızda",
      child: Center(
        child: Text("Hakkımızda Sayfası İçeriği"),
      ),
    );
  }
}