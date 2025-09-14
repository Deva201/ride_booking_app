import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  // UI state
  String _section = 'Bookings';

  // Business state

  int accepted = 0;
  int rejected = 0;
  int cancelled = 0;
  double earnings = 0.0;

  // Actions
  void _acceptBooking(int idx) {
    final b = bookingRequests.removeAt(idx);
    setState(() {
      accepted++;
      activeTrips.insert(0, {
        "id": b["id"],
        "pickup": b["pickup"],
        "drop": b["drop"],
        "fare": b["fare"],
        "status": "En route",
      });
    });

    showDialog(
      context: context,
      builder:
          (_) => _confirmationDialog(
            title: "Accepted",
            subtitle: "Drive to client location",
            color: Colors.orange.shade700,
            buttonText: "OK",
          ),
    );
  }

  void _rejectBooking(int idx) {
    bookingRequests.removeAt(idx);
    setState(() {
      rejected++;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Request rejected")));
  }

  void _completeTrip(int idx) {
    final t = activeTrips.removeAt(idx);
    setState(() {
      earnings += (t["fare"] as num).toDouble();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Trip ${t['id']} completed — earned ₹${t['fare']}"),
      ),
    );
  }

  void _cancelTrip(int idx) {
    final t = activeTrips.removeAt(idx);
    setState(() {
      cancelled++;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Trip ${t['id']} cancelled")));
  }

  // UI bits
  Widget _confirmationDialog({
    required String title,
    required String subtitle,
    required Color color,
    required String buttonText,
  }) {
    return Dialog(
      backgroundColor: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 56, color: Colors.white),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(subtitle, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () => Navigator.pop(context),
              child: Text(buttonText, style: TextStyle(color: color)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionButton(String key, IconData icon) {
    final selected = _section == key;
    return GestureDetector(
      onTap: () => setState(() => _section = key),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.white.withOpacity(0.15) : Colors.white24,
          borderRadius: BorderRadius.circular(14),
          border:
              selected
                  ? Border.all(color: Colors.white70.withOpacity(0.08))
                  : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text(
              key,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String label, String value, IconData icon, Color accent) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.95), accent.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: accent.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Business state
  List<Map<String, dynamic>> bookingRequests = [
    {
      "id": "B-101",
      "pickup": "Station Road",
      "drop": "Main Street",
      "fare": 220,
    },
    {"id": "B-102", "pickup": "Airport", "drop": "City Center", "fare": 380},
    {"id": "B-103", "pickup": "College Road", "drop": "Bus Stand", "fare": 180},
    {
      "id": "B-104",
      "pickup": "Hospital",
      "drop": "Railway Station",
      "fare": 250,
    },
    {"id": "B-105", "pickup": "Mall Road", "drop": "IT Park", "fare": 320},
    {
      "id": "B-106",
      "pickup": "Temple Street",
      "drop": "University",
      "fare": 210,
    },
    {"id": "B-107", "pickup": "Beach", "drop": "Central Market", "fare": 400},
    {"id": "B-108", "pickup": "Old Town", "drop": "New Bus Stand", "fare": 300},
  ];

  // Start with one active trip
  List<Map<String, dynamic>> activeTrips = [
    {
      "id": "T-201",
      "pickup": "Green Park",
      "drop": "Tech Hub",
      "fare": 450,
      "status": "En route",
    },
  ];

  Widget _bookingsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats Row
        Row(
          children: [
            _statCard(
              "Accepted",
              "$accepted",
              LineIcons.checkCircle,
              Colors.green,
            ),
            const SizedBox(width: 12),
            _statCard(
              "Earnings",
              "₹${earnings.toStringAsFixed(0)}",
              FontAwesomeIcons.wallet,
              Colors.deepOrange,
            ),
          ],
        ),
        const SizedBox(height: 18),

        // Requests title
        const Text(
          "New Requests",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        // Requests list (limited height)
        Flexible(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(16),
            ),
            child:
                bookingRequests.isEmpty
                    ? const Center(
                      child: Text(
                        "No new requests",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                    : ListView.builder(
                      itemCount: bookingRequests.length,
                      itemBuilder: (context, index) {
                        final b = bookingRequests[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.deepOrange.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  LineIcons.car,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Request ${b['id']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Pickup: ${b['pickup']}  •  Drop: ${b['drop']}",
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Fare: ₹${b['fare']}",
                                      style: const TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      FontAwesomeIcons.checkCircle,
                                      color: Colors.green,
                                    ),
                                    onPressed: () => _acceptBooking(index),
                                    tooltip: 'Accept',
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      FontAwesomeIcons.xmarkCircle,
                                      color: Colors.red,
                                    ),
                                    onPressed: () => _rejectBooking(index),
                                    tooltip: 'Reject',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ),

        const SizedBox(height: 14),

        // Active trips
        const Text(
          "Active Trips",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        Flexible(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(16),
            ),
            child:
                activeTrips.isEmpty
                    ? const Center(
                      child: Text(
                        "No active trips",
                        style: TextStyle(color: Colors.white70),
                      ),
                    )
                    : ListView.builder(
                      itemCount: activeTrips.length,
                      itemBuilder: (context, idx) {
                        final t = activeTrips[idx];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  LineIcons.car,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Trip ${t['id']}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "${t['pickup']} → ${t['drop']}",
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Status: ${t['status']}",
                                      style: const TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    onPressed: () => _completeTrip(idx),
                                    child: const Text("Complete"),
                                  ),
                                  const SizedBox(height: 8),
                                  OutlinedButton(
                                    onPressed: () => _cancelTrip(idx),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
          ),
        ),
      ],
    );
  }

  Widget _earningsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _statCard(
              "Earnings",
              "₹${earnings.toStringAsFixed(0)}",
              FontAwesomeIcons.wallet,
              Colors.deepOrange,
            ),
            const SizedBox(width: 12),
            _statCard(
              "Accepted",
              "$accepted",
              LineIcons.checkCircle,
              Colors.green,
            ),
          ],
        ),
        const SizedBox(height: 18),
        // Breakdown cards
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              _breakdownRow("Accepted Rides", accepted, Colors.green),
              const SizedBox(height: 10),
              _breakdownRow("Rejected Rides", rejected, Colors.red),
              const SizedBox(height: 10),
              _breakdownRow("Cancelled Rides", cancelled, Colors.grey),
            ],
          ),
        ),
        const SizedBox(height: 18),
        Expanded(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  FontAwesomeIcons.chartLine,
                  size: 64,
                  color: Colors.white70,
                ),
                const SizedBox(height: 12),
                const Text(
                  "Performance Summary",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  "Total trips: ${accepted + rejected + cancelled}",
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _breakdownRow(String label, int value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "$value",
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _profileView() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 44,
                backgroundColor: Colors.white,
                child: Icon(LineIcons.user, color: Colors.deepOrange, size: 40),
              ),
              const SizedBox(height: 12),
              const Text(
                "Driver Name",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Car: TN-12-3456",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "$accepted",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Accepted",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$rejected",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Rejected",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$cancelled",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Cancelled",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () {
                  // Simple logout flow: pop or navigate to login - demo uses a snack bar
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Logged out (demo)")),
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.deepOrange),
                label: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.deepOrange),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        // quick stats
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(
                  Icons.monetization_on,
                  color: Colors.white70,
                ),
                title: const Text(
                  "Total Earnings",
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: Text(
                  "₹${earnings.toStringAsFixed(0)}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const Divider(color: Colors.white24),
              ListTile(
                leading: const Icon(Icons.history, color: Colors.white70),
                title: const Text(
                  "Total Trips",
                  style: TextStyle(color: Colors.white70),
                ),
                trailing: Text(
                  "${accepted + rejected + cancelled}",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade400, Colors.deepOrange.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Driver Dashboard",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Good Morning, Driver",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _section = 'Profile';
                        });
                      },
                      child: CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white,
                        child: Icon(LineIcons.user, color: Colors.deepOrange),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Section selector
                Row(
                  children: [
                    Expanded(
                      child: _sectionButton('Bookings', FontAwesomeIcons.list),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _sectionButton(
                        'Earnings',
                        FontAwesomeIcons.wallet,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Content area (rounded glass-like)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Builder(
                        key: ValueKey(_section),
                        builder: (_) {
                          if (_section == 'Bookings') {
                            return _bookingsView();
                          } else if (_section == 'Earnings') {
                            return _earningsView();
                          } else {
                            return _profileView();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

