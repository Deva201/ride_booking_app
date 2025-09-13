// import 'package:flutter/material.dart';
//
// class CustomerDashboard extends StatefulWidget {
//   @override
//   _CustomerDashboardState createState() => _CustomerDashboardState();
// }
//
// class _CustomerDashboardState extends State<CustomerDashboard> {
//   TextEditingController pickupController = TextEditingController();
//   TextEditingController dropController = TextEditingController();
//
//   List<Map<String, String>> bookings = [];
//
//   void bookRide() {
//     if (pickupController.text.isEmpty || dropController.text.isEmpty) return;
//
//     setState(() {
//       bookings.add({
//         "pickup": pickupController.text,
//         "drop": dropController.text,
//         "status": "On The Way"
//       });
//     });
//
//     pickupController.clear();
//     dropController.clear();
//
//     // Show full screen success overlay
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (_) => Scaffold(
//         backgroundColor: Colors.blue.shade700.withOpacity(0.9),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.check_circle, size: 100, color: Colors.white),
//               SizedBox(height: 20),
//               Text("Ride Confirmed!",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 26,
//                       fontWeight: FontWeight.bold)),
//               SizedBox(height: 10),
//               Text("Your driver is on the way 🚖",
//                   style: TextStyle(color: Colors.white70, fontSize: 16)),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12)),
//                   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
//                 ),
//                 onPressed: () => Navigator.pop(context),
//                 child: Text("OK",
//                     style: TextStyle(
//                         color: Colors.blue.shade800,
//                         fontWeight: FontWeight.bold)),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [Colors.blue.shade400, Colors.blue.shade800],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight),
//         ),
//         child: SafeArea(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// --- TOP BAR ---
//               Padding(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.location_on, color: Colors.white),
//                         SizedBox(width: 6),
//                         Text("Sattur",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                                 color: Colors.white)),
//                       ],
//                     ),
//                     CircleAvatar(
//                       radius: 24,
//                       backgroundColor: Colors.white,
//                       child: Icon(Icons.person, color: Colors.blue.shade700),
//                     ),
//                   ],
//                 ),
//               ),
//
//               /// --- RIDE BOOKING FIELDS ---
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Container(
//                   padding: EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(18)),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: pickupController,
//                         style: TextStyle(color: Colors.white),
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.my_location,
//                               color: Colors.white70),
//                           hintText: "Pickup Location",
//                           hintStyle: TextStyle(color: Colors.white70),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                       Divider(color: Colors.white24),
//                       TextField(
//                         controller: dropController,
//                         style: TextStyle(color: Colors.white),
//                         decoration: InputDecoration(
//                           prefixIcon:
//                           Icon(Icons.location_on, color: Colors.redAccent),
//                           hintText: "Drop Location",
//                           hintStyle: TextStyle(color: Colors.white70),
//                           border: InputBorder.none,
//                         ),
//                       ),
//                       SizedBox(height: 16),
//                       ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           minimumSize: Size(double.infinity, 55),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(14)),
//                         ),
//                         onPressed: bookRide,
//                         icon: Icon(Icons.local_taxi,
//                             color: Colors.blue.shade700),
//                         label: Text("Book Now",
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.blue.shade700)),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: 20),
//
//               /// --- BOOKINGS LIST ---
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius:
//                     BorderRadius.vertical(top: Radius.circular(28)),
//                   ),
//                   child: bookings.isEmpty
//                       ? Center(
//                     child: Text("No bookings yet 🚖",
//                         style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey.shade600,
//                             fontStyle: FontStyle.italic)),
//                   )
//                       : ListView.builder(
//                       itemCount: bookings.length,
//                       itemBuilder: (context, index) {
//                         final booking = bookings[index];
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (_) => TrackingScreen(
//                                       pickup: booking["pickup"]!,
//                                       drop: booking["drop"]!,
//                                     )));
//                           },
//                           child: AnimatedBookingCard(
//                             pickup: booking["pickup"]!,
//                             drop: booking["drop"]!,
//                             status: booking["status"]!,
//                           ),
//                         );
//                       }),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// /// --- BOOKING CARD ---
// class AnimatedBookingCard extends StatelessWidget {
//   final String pickup;
//   final String drop;
//   final String status;
//
//   AnimatedBookingCard(
//       {required this.pickup, required this.drop, required this.status});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 14),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//             colors: status == "On The Way"
//                 ? [Colors.blue.shade400, Colors.blue.shade700]
//                 : [Colors.grey.shade200, Colors.grey.shade100]),
//         borderRadius: BorderRadius.circular(18),
//         boxShadow: [
//           BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
//         ],
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.local_taxi,
//               color: status == "On The Way" ? Colors.white : Colors.blueAccent,
//               size: 36),
//           SizedBox(width: 14),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Pickup: $pickup",
//                     style: TextStyle(
//                         color: status == "On The Way"
//                             ? Colors.white
//                             : Colors.black,
//                         fontWeight: FontWeight.w600)),
//                 Text("Drop: $drop",
//                     style: TextStyle(
//                         color: status == "On The Way"
//                             ? Colors.white70
//                             : Colors.grey.shade700)),
//               ],
//             ),
//           ),
//           Icon(Icons.location_on,
//               color:
//               status == "On The Way" ? Colors.redAccent : Colors.blueAccent,
//               size: 28),
//         ],
//       ),
//     );
//   }
// }
//
// /// --- TRACKING SCREEN ---
// class TrackingScreen extends StatelessWidget {
//   final String pickup;
//   final String drop;
//
//   TrackingScreen({required this.pickup, required this.drop});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue.shade50,
//       appBar: AppBar(
//         title: Text("Tracking Ride"),
//         backgroundColor: Colors.blue.shade700,
//       ),
//       body: Center(
//         child: Container(
//           margin: EdgeInsets.all(20),
//           padding: EdgeInsets.all(20),
//           height: 300,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
//               ]),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.local_taxi,
//                   size: 80, color: Colors.blue.shade700),
//               SizedBox(height: 20),
//               Text("Driver is on the way...",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18,
//                       color: Colors.blue.shade800)),
//               SizedBox(height: 10),
//               Text("Pickup: $pickup\nDrop: $drop",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(color: Colors.grey.shade700)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: CustomerDashboard(),
    debugShowCheckedModeBanner: false,
  ));
}

/// -------------------- DASHBOARD --------------------
class CustomerDashboard extends StatelessWidget {
  final List<Map<String, String>> spots = [
    {
      "title": "Courtallam Falls",
      "subtitle": "Waterfalls & Adventure",
      "image":
      "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fit=crop&w=600&q=80"
    },
    {
      "title": "Ooty Hills",
      "subtitle": "Nature & Relaxation",
      "image":
      "https://images.unsplash.com/photo-1501785888041-af3ef285b470?fit=crop&w=600&q=80"
    },
    {
      "title": "Madurai Meenakshi Temple",
      "subtitle": "Historic & Spiritual",
      "image":
      "https://images.unsplash.com/photo-1503220317375-aaad61436b1b?fit=crop&w=600&q=80"
    },
    {
      "title": "Marina Beach",
      "subtitle": "Relaxation & Sunset",
      "image":
      "https://images.unsplash.com/photo-1507525428034-b723cf961d3e?fit=crop&w=600&q=80"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tamil Nadu Explorer",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => CustomerProfileScreen())),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.blue.shade700),
                      ),
                    )
                  ],
                ),
              ),

              /// Book Ride Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => BookingScreen()));
                  },
                  child: Text("🚖 Book a Ride",
                      style: TextStyle(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
              ),

              SizedBox(height: 20),

              /// Popular Places
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Popular Places in Tamil Nadu",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              SizedBox(height: 14),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: spots.length,
                  itemBuilder: (context, index) {
                    final spot = spots[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      height: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(spot["image"]!),
                              fit: BoxFit.cover)),
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.black45,
                                      Colors.transparent
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter)),
                          ),
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(spot["title"]!,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                                Text(spot["subtitle"]!,
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 13)),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// -------------------- BOOKING SCREEN --------------------
class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController pickupController = TextEditingController();
  TextEditingController dropController = TextEditingController();

  List<Map<String, String>> bookings = [];

  void bookRide() {
    if (pickupController.text.isEmpty || dropController.text.isEmpty) return;

    setState(() {
      bookings.add({
        "pickup": pickupController.text,
        "drop": dropController.text,
        "status": "On The Way"
      });
    });

    pickupController.clear();
    dropController.clear();

    // Full screen success
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Scaffold(
          backgroundColor: Colors.blue.shade700.withOpacity(0.9),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 90),
                SizedBox(height: 20),
                Text("Ride Confirmed!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white),
                    onPressed: () => Navigator.pop(context),
                    child: Text("OK",
                        style: TextStyle(
                            color: Colors.blue.shade800,
                            fontWeight: FontWeight.bold)))
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: SafeArea(
          child: Column(
            children: [
              /// Fields
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      TextField(
                        controller: pickupController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon:
                          Icon(Icons.my_location, color: Colors.white),
                          hintText: "Pickup Location",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                      Divider(color: Colors.white24),
                      TextField(
                        controller: dropController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon:
                          Icon(Icons.location_on, color: Colors.redAccent),
                          hintText: "Drop Location",
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        onPressed: bookRide,
                        icon: Icon(Icons.local_taxi,
                            color: Colors.blue.shade700),
                        label: Text("Book Now",
                            style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              ),

              /// Booking History
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(26))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Your Bookings",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blue.shade900)),
                      SizedBox(height: 14),
                      Expanded(
                        child: bookings.isEmpty
                            ? Center(child: Text("No bookings yet 🚖"))
                            : ListView.builder(
                            itemCount: bookings.length,
                            itemBuilder: (context, i) {
                              final b = bookings[i];
                              return Card(
                                margin: EdgeInsets.only(bottom: 12),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(16)),
                                child: ListTile(
                                  leading: Icon(Icons.local_taxi,
                                      color: Colors.blue.shade700),
                                  title: Text(
                                      "Pickup: ${b["pickup"]} → Drop: ${b["drop"]}"),
                                  subtitle: Text(b["status"]!,
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w600)),
                                ),
                              );
                            }),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade400,
                              minimumSize: Size(double.infinity, 50)),
                          onPressed: () => Navigator.pop(context),
                          child: Text("⬅ Back to Dashboard",
                              style: TextStyle(color: Colors.white)))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// -------------------- PROFILE SCREEN --------------------
class CustomerProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int totalOrders = 12;
    int activeRides = 2;
    int completedRides = 10;

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue.shade400, Colors.blue.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person,
                      size: 60, color: Colors.blue.shade700),
                ),
                SizedBox(height: 20),
                Text("Customer Profile",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                _profileCard("Total Orders", "$totalOrders"),
                _profileCard("Active Rides", "$activeRides"),
                _profileCard("Completed Rides", "$completedRides"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileCard(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: TextStyle(color: Colors.white70, fontSize: 16)),
          Text(value,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
        ],
      ),
    );
  }
}
