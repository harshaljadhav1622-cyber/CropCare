import 'package:cropdisease/loginpage.dart';
import 'package:flutter/material.dart';

void main() {
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
    return MaterialApp(home: Loginpage());
  }
}
