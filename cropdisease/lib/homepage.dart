import 'package:cropdisease/historypage.dart';
import 'package:cropdisease/profilepage.dart';
import 'package:cropdisease/scanpage.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F3),

      // =====================================================
      // APP BAR
      // =====================================================
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 0,

        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "CropCare 🌱",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),

            Text(
              "Healthy crops, better harvests",
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {
              // TODO:
              // Open notification page
            },
            icon: const Icon(Icons.notifications_none),
          ),

          IconButton(
            onPressed: () {
              // TODO:
              // Open farmer profile page
            },
            icon: const Icon(Icons.person_outline),
          ),

          const SizedBox(width: 5),
        ],
      ),

      // =====================================================
      // BODY
      // =====================================================
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 25),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // =================================================
            // WELCOME
            // =================================================
            const Text(
              "Namaste, Farmer 👋",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B5E20),
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "Let's keep your crops healthy.",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),

            const SizedBox(height: 22),

            // =================================================
            // MAIN SCAN SECTION
            // =================================================
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ScanPage()),
                );
              },

              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),

                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32),
                  borderRadius: BorderRadius.circular(22),
                ),

                child: Column(
                  children: [
                    // Scan Icon
                    Container(
                      height: 75,
                      width: 75,

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),

                      child: const Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),

                    const SizedBox(height: 15),

                    const Text(
                      "Scan Your Crop",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 7),

                    const Text(
                      "Take a photo of your crop leaf\nto check for diseases",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),

                    const SizedBox(height: 17),

                    // Scan Button
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 11,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),

                      child: const Row(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: Color(0xFF2E7D32),
                            size: 20,
                          ),

                          SizedBox(width: 8),

                          Text(
                            "Start Scanning",
                            style: TextStyle(
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // QUICK ACTIONS
            // =================================================
            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                // My Crops
                Expanded(
                  child: _actionCard(
                    icon: Icons.grass,
                    title: "My Crops",
                    subtitle: "Manage crops",
                    onTap: () {
                      // TODO:
                      // Navigate to My Crops page
                    },
                  ),
                ),

                const SizedBox(width: 12),

                // Scan History
                Expanded(
                  child: _actionCard(
                    icon: Icons.history,
                    title: "Scan History",
                    subtitle: "Previous scans",
                    onTap: () {
                      // TODO:
                      // Navigate to Scan History page
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                // Disease Information
                Expanded(
                  child: _actionCard(
                    icon: Icons.local_florist_outlined,
                    title: "Crop Diseases",
                    subtitle: "Learn & identify",
                    onTap: () {
                      // TODO:
                      // Navigate to Crop Disease Information page
                    },
                  ),
                ),

                const SizedBox(width: 12),

                // Weather
                Expanded(
                  child: _actionCard(
                    icon: Icons.cloud_outlined,
                    title: "Weather",
                    subtitle: "Today's weather",
                    onTap: () {
                      // TODO:
                      // Navigate to Weather page
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // =================================================
            // SIMPLE INFORMATION CARD
            // =================================================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),

                border: Border.all(color: const Color(0xFFE0E8DD)),
              ),

              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,

                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: const Icon(
                      Icons.lightbulb_outline,
                      color: Color(0xFF2E7D32),
                      size: 28,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Crop Care Tip",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "Check your crop leaves regularly "
                          "for early signs of disease.",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // HELP SECTION
            // =================================================
            GestureDetector(
              onTap: () {
                // TODO:
                // Navigate to Help / Agriculture Expert page
              },

              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(17),

                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: const Row(
                  children: [
                    Icon(
                      Icons.support_agent,
                      color: Color(0xFF2E7D32),
                      size: 32,
                    ),

                    SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            "Need Help?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          SizedBox(height: 3),

                          Text(
                            "Get guidance for your crop",
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ],
                      ),
                    ),

                    Icon(
                      Icons.arrow_forward_ios,
                      size: 17,
                      color: Color(0xFF2E7D32),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,

        selectedItemColor: const Color(0xFF2E7D32),
        unselectedItemColor: Colors.grey,

        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            activeIcon: Icon(Icons.camera_alt),
            label: "Scan",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: "History",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],

        onTap: (index) {
          // 0 = Home
          // Already on Homepage, so do nothing.

          // 1 = Scan
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScanPage()),
            );
          }

          // 2 = History
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HistoryPage()),
            );
          }

          // 3 = Profile
          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
      ),
    );
  }

  // =========================================================
  // QUICK ACTION CARD WIDGET
  // =========================================================

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),

          border: Border.all(color: const Color(0xFFE0E8DD)),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Container(
              height: 45,
              width: 45,

              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Icon(icon, color: const Color(0xFF2E7D32), size: 25),
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),

            const SizedBox(height: 3),

            Text(
              subtitle,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
