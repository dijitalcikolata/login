import 'package:flutter/material.dart';
import '../components/main_scaffold.dart';

class EgitimScreen extends StatelessWidget {
  const EgitimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      title: "Eğitim",
      child: Center(
        child: Text("Eğitim Sayfası İçeriği"),
      ),
    );
  }
}