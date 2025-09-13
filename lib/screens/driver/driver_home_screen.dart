import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  int _selectedIndex = 0;

  // Dummy pages
  late final List<Widget> _pages = [
    // 1️⃣ Bookings Page
    ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 4,
          child: ListTile(
            leading: const Icon(LineIcons.car, color: Colors.green, size: 32),
            title: const Text("New Booking Request"),
            subtitle: const Text("Pickup: Station Road\nDrop: Main Street"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.checkCircle, color: Colors.green),
                  onPressed: () {}, // Accept booking
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.xmarkCircle, color: Colors.red),
                  onPressed: () {}, // Reject booking
                ),
              ],
            ),
          ),
        ),
      ],
    ),

    // 2️⃣ Earnings Page
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(FontAwesomeIcons.wallet, size: 64, color: Colors.blue),
          SizedBox(height: 10),
          Text(
            "Total Earnings",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text("₹ 1,250 (This Week)", style: TextStyle(fontSize: 18)),
        ],
      ),
    ),

    // 3️⃣ Profile Page
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.green,
            child: Icon(FontAwesomeIcons.user, size: 50, color: Colors.white), // ✅ safe for Web
          ),
          SizedBox(height: 10),
          Text(
            "Driver Name",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text("Car: TN-12-3456",
              style: TextStyle(fontSize: 16, color: Colors.grey)),
          SizedBox(height: 20),
          Text("Status: Online",
              style: TextStyle(fontSize: 18, color: Colors.green)),
        ],
      ),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver Dashboard"),
        backgroundColor: Colors.green,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.listAlt),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.wallet),
            label: "Earnings",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
