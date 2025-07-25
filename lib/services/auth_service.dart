import 'dart:convert';
import 'dart:math';
import 'dart:io' show Platform;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


/// sign_in_with_apple sadece iOS'ta kullanılmalı:
/// dart-define ile import edilmediği sürece Android derlemesinde patlamaması için,
/// kod iOS dışında çalıştırılmamalı
/// Bu import hatasını çözmek için conditional import da düşünebiliriz ama şimdilik
/// Apple giriş kodlarını platform kontrolü içinde tutmak yeterli.

class AuthService {
  // 🔹 Google ile Giriş
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      final docRef = FirebaseFirestore.instance.collection('users').doc(user!.uid);
      final doc = await docRef.get();

      if (!doc.exists) {
        await docRef.set({
          'adSoyad': user.displayName ?? '',
          'email': user.email ?? '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return userCredential;
    } catch (e) {
      print("Google Sign-In Hatası: $e");
      return null;
    }
  }

  // 🍏 Apple ile Giriş (yalnızca iOS)


  // 🔐 Nonce üretici

}