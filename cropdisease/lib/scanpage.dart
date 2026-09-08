import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  File? selectedImage;
  bool isScanning = false;
  bool showResult = false;

  final ImagePicker picker = ImagePicker();

  // Pick image from gallery
  Future<void> pickFromGallery() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        showResult = false;
      });
    }
  }

  // Take photo using camera
  Future<void> takePhoto() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        showResult = false;
      });
    }
  }

  // Start scanning
  Future<void> scanCrop() async {
    if (selectedImage == null) return;

    setState(() {
      isScanning = true;
      showResult = false;
    });

    // TODO:
    // Replace this delay with your AI/API disease detection code.
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    setState(() {
      isScanning = false;
      showResult = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Crop Disease Scanner",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // Heading
            const Text(
              "Scan Your Crop",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Take a photo or select an image of the affected crop.",
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            // Image container
            Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 2,
                ),
              ),
              child: selectedImage == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.image_search,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "No image selected",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
            ),

            const SizedBox(height: 20),

            // Camera + Gallery buttons
            Row(
              children: [

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isScanning ? null : takePhoto,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Take Photo"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isScanning ? null : pickFromGallery,
                    icon: const Icon(Icons.photo_library),
                    label: const Text("Gallery"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Scan button
            ElevatedButton.icon(
              onPressed:
                  selectedImage == null || isScanning
                      ? null
                      : scanCrop,
              icon: const Icon(Icons.search),
              label: const Text(
                "Scan Crop",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Loading / Progress
            if (isScanning)
              Column(
                children: const [

                  Text(
                    "Analyzing crop image...",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 15),

                  LinearProgressIndicator(
                    minHeight: 8,
                  ),

                  SizedBox(height: 10),

                  Text(
                    "Please wait while we detect the disease.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

            // Result
            if (showResult)
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.green.shade50,
                  border: Border.all(
                    color: Colors.green.shade200,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [

                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 30,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Scan Complete",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 15),

                    Text(
                      "Detected Disease",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      "Leaf Blight",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Confidence: 92%",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),

                    SizedBox(height: 15),

                    Text(
                      "Treatment: Remove affected leaves and "
                      "use the recommended fungicide.",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}