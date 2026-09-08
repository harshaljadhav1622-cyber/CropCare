import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Scan History",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // =====================================================
      // STREAM BUILDER
      // This will get the previous scan data from Firestore
      // =====================================================

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('scans')

            // IMPORTANT:
            // Only get scans belonging to the currently
            // logged-in farmer.
            .where(
              'userId',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid,
            )

            // Show latest scans first
            .orderBy(
              'date',
              descending: true,
            )

            // Listen for changes in Firestore
            .snapshots(),

        builder: (context, snapshot) {

          // =================================================
          // LOADING
          // =================================================

          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // =================================================
          // ERROR
          // =================================================

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something went wrong.",
              ),
            );
          }

          // =================================================
          // NO HISTORY
          // If the farmer has never scanned a crop
          // =================================================

          if (!snapshot.hasData ||
              snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Icon(
                    Icons.history,
                    size: 70,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 15),

                  Text(
                    "No scan history yet",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    "Your previous crop scans will appear here.",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          // =================================================
          // GET ALL SCANS
          // =================================================

          final scans = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),

            // Number of cards = number of scans
            itemCount: scans.length,

            itemBuilder: (context, index) {

              // =================================================
              // GET ONE SCAN
              //
              // Example Firestore document:
              //
              // scans
              //   └── scanId
              //        ├── userId
              //        ├── cropName
              //        ├── disease
              //        ├── confidence
              //        ├── treatment
              //        ├── imageUrl
              //        └── date
              // =================================================

              final scan =
                  scans[index].data()
                      as Map<String, dynamic>;

              // =================================================
              // GET DATA FROM FIRESTORE
              // =================================================

              // From ScanPage / AI result
              final String cropName =
                  scan['cropName'] ?? 'Unknown Crop';

              // Disease detected by AI
              final String disease =
                  scan['disease'] ?? 'Unknown Disease';

              // AI confidence percentage
              final dynamic confidence =
                  scan['confidence'] ?? 0;

              // Image URL from Firebase Storage
              // We will use this later to display
              // the actual crop image.
              final String? imageUrl =
                  scan['imageUrl'];

              // Scan date saved in Firestore
              final Timestamp? timestamp =
                  scan['date'];

              // Convert Firestore timestamp into DateTime
              final DateTime? scanDate =
                  timestamp?.toDate();

              // =================================================
              // HISTORY CARD
              // =================================================

              return Card(
                margin: const EdgeInsets.only(
                  bottom: 15,
                ),

                elevation: 2,

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(12),

                  child: Row(
                    children: [

                      // =========================================
                      // CROP IMAGE
                      //
                      // imageUrl will come from Firebase Storage.
                      //
                      // FOR NOW:
                      // If imageUrl is not available,
                      // show a leaf icon.
                      // =========================================

                      ClipRRect(
                        borderRadius:
                            BorderRadius.circular(12),

                        child: imageUrl != null &&
                                imageUrl.isNotEmpty
                            ? Image.network(
                                imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 80,
                                height: 80,
                                color: Colors.green.shade50,

                                child: const Icon(
                                  Icons.local_florist,
                                  size: 40,
                                  color: Colors.green,
                                ),
                              ),
                      ),

                      const SizedBox(width: 15),

                      // =========================================
                      // SCAN INFORMATION
                      // =========================================

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            // -------------------------------
                            // CROP NAME
                            //
                            // Comes from:
                            // Firestore -> cropName
                            // -------------------------------

                            Text(
                              cropName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 5),

                            // -------------------------------
                            // DISEASE
                            //
                            // Comes from:
                            // AI result -> Firestore -> disease
                            // -------------------------------

                            Text(
                              disease,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade700,
                              ),
                            ),

                            const SizedBox(height: 5),

                            // -------------------------------
                            // CONFIDENCE
                            //
                            // Comes from:
                            // AI model -> Firestore -> confidence
                            // -------------------------------

                            Text(
                              "Confidence: $confidence%",
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 5),

                            // -------------------------------
                            // DATE
                            //
                            // Comes from:
                            // Firestore -> date
                            // -------------------------------

                            Text(
                              scanDate != null
                                  ? "${scanDate.day}/"
                                    "${scanDate.month}/"
                                    "${scanDate.year}"
                                  : "Date unavailable",

                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // =========================================
                      // ARROW
                      //
                      // Later this will open ResultDetailsPage
                      // to show the complete treatment,
                      // symptoms, prevention, etc.
                      // =========================================

                      IconButton(
                        onPressed: () {

                          // TODO:
                          // Navigate to ResultDetailsPage
                          //
                          // We can pass the complete 'scan'
                          // map to that page.
                          //
                          // Example later:
                          //
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //       ResultDetailsPage(
                          //         scanData: scan,
                          //       ),
                          //   ),
                          // );

                        },

                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}