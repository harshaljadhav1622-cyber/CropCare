import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ================= LOGOUT =================
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ================= APP BAR =================
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            // ================= PROFILE PHOTO =================
            const CircleAvatar(
              radius: 55,
              backgroundColor: Colors.green,
              child: Icon(Icons.person, size: 65, color: Colors.white),
            ),

            const SizedBox(height: 15),

            // ================= USER NAME & EMAIL =================
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("farmers")
                  .where(
                    "email",
                    isEqualTo: FirebaseAuth.instance.currentUser?.email,
                  )
                  .limit(1)
                  .get(),

              builder: (context, snapshot) {
                // Loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                // Error
                if (snapshot.hasError) {
                  return const Text(
                    "Something went wrong",
                    style: TextStyle(color: Colors.red),
                  );
                }

                // Farmer not found
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text(
                    "Farmer not found",
                    style: TextStyle(color: Colors.grey),
                  );
                }

                // Get farmer document
                final farmer = snapshot.data!.docs.first;

                // Get name and email
                final String name = farmer["name"];
                final String email = farmer["email"];

                // Display name and email
                return Column(
                  children: [
                    // Farmer Name
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // Farmer Email
                    Text(
                      email,
                      style: const TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 30),

            // ================= PROFILE DETAILS =================
            profileOption(
              icon: Icons.person_outline,
              title: "Personal Information",
              onTap: () {
                // TODO:
                // Navigate to Personal Information page
              },
            ),

            profileOption(
              icon: Icons.history,
              title: "Scan History",
              onTap: () {
                // TODO:
                // Navigate to Scan History page
              },
            ),

            profileOption(
              icon: Icons.language,
              title: "Language",
              onTap: () {
                // TODO:
                // Add language selection here
              },
            ),

            profileOption(
              icon: Icons.help_outline,
              title: "Help & Support",
              onTap: () {
                // TODO:
                // Navigate to Help & Support page
              },
            ),

            profileOption(
              icon: Icons.info_outline,
              title: "About App",
              onTap: () {
                // TODO:
                // Show information about the application
              },
            ),

            const SizedBox(height: 20),

            // ================= LOGOUT BUTTON =================
            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: logout,

                icon: const Icon(Icons.logout),

                label: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),

                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= PROFILE OPTION =================

  Widget profileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        onTap: onTap,

        leading: CircleAvatar(
          backgroundColor: Colors.green.shade50,

          child: Icon(icon, color: Colors.green),
        ),

        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),

        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
