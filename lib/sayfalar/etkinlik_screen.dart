import 'package:flutter/material.dart';
import '../components/main_scaffold.dart';

class EtkinlikScreen extends StatelessWidget {
  const EtkinlikScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainScaffold(
      title: "Etkinlik",
      child: Center(
        child: Text("Etkinlik Sayfası İçeriği"),
      ),
    );
  }
}