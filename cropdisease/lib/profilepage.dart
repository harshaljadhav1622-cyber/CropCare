import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

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

            // ================= USER NAME =================
            const Text(
              "Farmer Name",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              "farmer@example.com",
              style: TextStyle(color: Colors.grey, fontSize: 15),
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
                onPressed: () {
                  // TODO:
                  // Add Firebase logout here
                },
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

  static Widget profileOption({
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
