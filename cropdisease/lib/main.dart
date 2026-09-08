import 'package:cropdisease/authwrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const CropDisease());
}

class CropDisease extends StatefulWidget {
  const CropDisease({super.key});

  @override
  State<CropDisease> createState() => _CropDiseaseState();
}

class _CropDiseaseState extends State<CropDisease> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Authwrapper());
  }
}
