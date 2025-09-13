import 'package:flutter/material.dart';

class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  List<Map<String, String>> spots = [
    {
      "title": "Vaippar Dam",
      "subtitle": "Nature & Relaxation",
      "image":
      "https://images.unsplash.com/photo-1506744038136-46273834b3fb?fit=crop&w=600&q=80"
    },
    {
      "title": "Thiruchuli Temple",
      "subtitle": "Historic & Spiritual",
      "image":
      "https://images.unsplash.com/photo-1506744038136-46273834b3fb?fit=crop&w=600&q=80"
    },
    {
      "title": "Courtallam Falls",
      "subtitle": "Waterfalls & Adventure",
      "image":
      "https://images.unsplash.com/photo-1506744038136-46273834b3fb?fit=crop&w=600&q=80"
    },
    {
      "title": "Sattur Food Street",
      "subtitle": "Local Flavors",
      "image":
      "https://images.unsplash.com/photo-1506744038136-46273834b3fb?fit=crop&w=600&q=80"
    },
  ];

  List<Map<String, String>> bookings = [];

  TextEditingController pickupController = TextEditingController();
  TextEditingController dropController = TextEditingController();

  void bookTrip(String title, String pickup, String drop) {
    setState(() {
      bookings.add({
        "title": title,
        "pickup": pickup,
        "drop": drop,
        "status": "On The Way",
      });
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Success"),
        content: Text("Your trip to $title has been booked successfully!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );

    pickupController.clear();
    dropController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.blue.shade700),
                      SizedBox(width: 6),
                      Text(
                        "Sattur",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.blue.shade700,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10),

            // Welcome Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.blue.shade600, Colors.blue.shade400]),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26, blurRadius: 12, offset: Offset(0, 6))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello! Book Your Ride",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18)),
                      child: Column(
                        children: [
                          TextField(
                            controller: pickupController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.my_location,
                                    color: Colors.blue),
                                hintText: "Pickup Location",
                                border: InputBorder.none),
                          ),
                          Divider(color: Colors.grey.shade300),
                          TextField(
                            controller: dropController,
                            decoration: InputDecoration(
                                prefixIcon:
                                Icon(Icons.location_on, color: Colors.red),
                                hintText: "Drop Location",
                                border: InputBorder.none),
                          ),
                          SizedBox(height: 12),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              if (pickupController.text.isNotEmpty &&
                                  dropController.text.isNotEmpty) {
                                bookTrip(
                                    "Custom Trip",
                                    pickupController.text,
                                    dropController.text);
                              }
                            },
                            child: Text("Book Now",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 15),

            // Featured Spots
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "Popular Spots",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900),
                  ),
                  Spacer(),
                  Text("See all",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade600)),
                ],
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 180,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: spots.length,
                  itemBuilder: (context, index) {
                    final spot = spots[index];
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text("Book Spot"),
                              content: Text(
                                  "Do you want to book a trip to ${spot['title']}?"),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Cancel")),
                                ElevatedButton(
                                    onPressed: () {
                                      bookTrip(
                                          spot['title']!,
                                          "Home",
                                          spot['title']!);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Book Now"))
                              ],
                            ));
                      },
                      child: Container(
                        width: 160,
                        margin: EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(spot["image"]!), fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 4))
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      colors: [Colors.black45, Colors.transparent],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter)),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              right: 10,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(spot["title"]!,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                  SizedBox(height: 4),
                                  Text(spot["subtitle"]!,
                                      style: TextStyle(
                                          color: Colors.white70, fontSize: 12)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),

            SizedBox(height: 15),

            // Your Bookings
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Bookings",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade900),
                    ),
                    SizedBox(height: 12),
                    Expanded(
                      child: bookings.isEmpty
                          ? Center(
                        child: Text(
                          "No bookings yet",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic),
                        ),
                      )
                          : ListView.builder(
                          itemCount: bookings.length,
                          itemBuilder: (context, index) {
                            final booking = bookings[index];
                            return AnimatedBookingCard(
                              title: booking["title"]!,
                              pickup: booking["pickup"]!,
                              drop: booking["drop"]!,
                              status: booking["status"]!,
                            );
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Booking Card
class AnimatedBookingCard extends StatelessWidget {
  final String title;
  final String pickup;
  final String drop;
  final String status;

  AnimatedBookingCard(
      {required this.title,
        required this.pickup,
        required this.drop,
        required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: status == "On The Way"
            ? LinearGradient(colors: [Colors.blue.shade400, Colors.blue.shade600])
            : LinearGradient(colors: [Colors.grey.shade200, Colors.grey.shade100]),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.directions_car,
              color: status == "On The Way" ? Colors.white : Colors.blueAccent,
              size: 40),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: status == "On The Way" ? Colors.white : Colors.black,
                        fontSize: 16)),
                SizedBox(height: 4),
                Text("Pickup: $pickup\nDrop: $drop",
                    style: TextStyle(
                        fontSize: 12,
                        color: status == "On The Way"
                            ? Colors.white70
                            : Colors.grey.shade700)),
              ],
            ),
          ),
          Icon(Icons.location_on,
              color: status == "On The Way" ? Colors.redAccent : Colors.blueAccent,
              size: 30)
        ],
      ),
    );
  }
}
