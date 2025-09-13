import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  String _selectedPage = "Dashboard";

  final List<String> _quickActions = [
    "Dashboard",
    "Payments",
    "Drivers",
    "Reports",
    "Support",
    "Profile"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildHeader(),
              const SizedBox(height: 24),
              _buildQuickActionBar(),
              const SizedBox(height: 16),
              Expanded(child: _buildContent()),
            ],
          ),
        ),
      ),
    );
  }

  /// Header with profile avatar
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Welcome Back 👋",
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 6),
              Text(_selectedPage,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white,
            child: Icon(Icons.person_rounded, color: Colors.purpleAccent),
          )
        ],
      ),
    );
  }

  /// Quick action bar
  Widget _buildQuickActionBar() {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _quickActions.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final action = _quickActions[index];
          final isSelected = _selectedPage == action;
          final color = isSelected ? Colors.white : Colors.white70;
          return GestureDetector(
            onTap: () => setState(() => _selectedPage = action),
            child: Container(
              width: 90,
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                    colors: [Colors.purpleAccent, Colors.blueAccent])
                    : null,
                color: isSelected ? null : Colors.white24,
                borderRadius: BorderRadius.circular(18),
                boxShadow: isSelected
                    ? [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8)
                ]
                    : [],
              ),
              child: Center(
                  child: Text(action,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 13))),
            ),
          );
        },
      ),
    );
  }

  /// Content changes based on selected action
  Widget _buildContent() {
    switch (_selectedPage) {
      case "Dashboard":
        return _dashboardContent();
      case "Payments":
        return _paymentsContent();
      case "Drivers":
        return _driversContent();
      case "Reports":
        return _reportsContent();
      case "Support":
        return _supportContent();
      case "Profile":
        return _profileContent();
      default:
        return Center(
            child: Text("Coming Soon",
                style: TextStyle(color: Colors.white, fontSize: 18)));
    }
  }

  /// Dashboard main content
  Widget _dashboardContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: _statCard("Total Rides", "1,245", Colors.blueAccent,
                      FontAwesomeIcons.taxi)),
              const SizedBox(width: 16),
              Expanded(
                  child: _statCard("Revenue", "₹2,54,300", Colors.greenAccent,
                      FontAwesomeIcons.wallet)),
            ],
          ),
          const SizedBox(height: 24),
          _recentBookingsSection()
        ],
      ),
    );
  }

  /// Payments content
  Widget _paymentsContent() {
    final payments = [
      ["PAY-101", "Customer A", "₹500", "Completed"],
      ["PAY-102", "Customer B", "₹1200", "Pending"],
      ["PAY-103", "Customer C", "₹750", "Completed"],
      ["PAY-104", "Customer D", "₹350", "Failed"],
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: _statCard("Total Paid", "₹4,500", Colors.green,
                      FontAwesomeIcons.moneyCheck)),
              const SizedBox(width: 16),
              Expanded(
                  child: _statCard("Pending Amount", "₹1,550", Colors.orange,
                      FontAwesomeIcons.hourglassHalf)),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: payments.length,
              itemBuilder: (context, index) {
                final p = payments[index];
                final statusColor = p[3] == "Completed"
                    ? Colors.green
                    : p[3] == "Pending"
                    ? Colors.orange
                    : Colors.red;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 6)
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 24,
                          backgroundColor: statusColor.withOpacity(0.3),
                          child: Icon(Icons.payment, color: Colors.white)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p[0],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(p[1],
                                  style:
                                  const TextStyle(color: Colors.white70)),
                              Text(p[2],
                                  style:
                                  const TextStyle(color: Colors.white60)),
                            ]),
                      ),
                      Text(p[3],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: statusColor))
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  /// Drivers content
  Widget _driversContent() {
    final drivers = [
      ["Driver A", "Active", "5 Rides Today"],
      ["Driver B", "Inactive", "0 Rides Today"],
      ["Driver C", "Active", "7 Rides Today"],
      ["Driver D", "Active", "3 Rides Today"],
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: _statCard("Total Drivers", "350", Colors.indigoAccent,
                      FontAwesomeIcons.carSide)),
              const SizedBox(width: 16),
              Expanded(
                  child: _statCard("Active Today", "220", Colors.greenAccent,
                      FontAwesomeIcons.userCheck)),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            height: 350,
            child: ListView.builder(
              itemCount: drivers.length,
              itemBuilder: (context, index) {
                final d = drivers[index];
                final statusColor =
                d[1] == "Active" ? Colors.green : Colors.redAccent;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 6)
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 24,
                          backgroundColor: statusColor.withOpacity(0.3),
                          child: Icon(Icons.drive_eta, color: Colors.white)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(d[0],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(d[2],
                                  style: const TextStyle(color: Colors.white70)),
                            ]),
                      ),
                      Text(d[1],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: statusColor))
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  /// Reports content
  Widget _reportsContent() {
    final reports = [
      ["Daily Report", "₹12,000", "45 Rides"],
      ["Weekly Report", "₹80,000", "310 Rides"],
      ["Monthly Report", "₹3,20,000", "1250 Rides"],
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: _statCard("Revenue Today", "₹12,000", Colors.green,
                      FontAwesomeIcons.coins)),
              const SizedBox(width: 16),
              Expanded(
                  child: _statCard("Total Rides", "1,245", Colors.blueAccent,
                      FontAwesomeIcons.taxi)),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            height: 300,
            child: ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final r = reports[index];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 6)
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(r[0],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(r[1], style: const TextStyle(color: Colors.white70)),
                          Text(r[2], style: const TextStyle(color: Colors.white60)),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  /// Support content
  Widget _supportContent() {
    final tickets = [
      ["Ticket #101", "Customer A", "Pending"],
      ["Ticket #102", "Customer B", "Resolved"],
      ["Ticket #103", "Customer C", "In Progress"],
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: _statCard("Open Tickets", "12", Colors.redAccent,
                      FontAwesomeIcons.headset)),
              const SizedBox(width: 16),
              Expanded(
                  child: _statCard("Resolved Today", "5", Colors.greenAccent,
                      FontAwesomeIcons.checkCircle)),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            height: 300,
            child: ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final t = tickets[index];
                final statusColor = t[2] == "Resolved"
                    ? Colors.green
                    : t[2] == "Pending"
                    ? Colors.orange
                    : Colors.blueAccent;
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1), blurRadius: 6)
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 24,
                          backgroundColor: statusColor.withOpacity(0.3),
                          child: Icon(Icons.support_agent, color: Colors.white)),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(t[0],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                              Text(t[1],
                                  style:
                                  const TextStyle(color: Colors.white70)),
                            ]),
                      ),
                      Text(t[2],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: statusColor))
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  /// Profile content
  Widget _profileContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white24, borderRadius: BorderRadius.circular(18)),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person_rounded, size: 40, color: Colors.purpleAccent),
                ),
                const SizedBox(height: 16),
                const Text("Admin Name",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),
                const SizedBox(height: 8),
                const Text("admin@example.com",
                    style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _profileStat("Rides", "1245"),
                    _profileStat("Revenue", "₹2,54,300"),
                    _profileStat("Drivers", "350"),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _profileStat(String title, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12))
      ],
    );
  }

  /// Recent bookings section
  Widget _recentBookingsSection() {
    final bookings = [
      ["RIDE-101", "Customer A", "Station → Market", "₹120"],
      ["RIDE-102", "Customer B", "Airport → Mall", "₹420"],
      ["RIDE-103", "Customer C", "Metro → Park", "₹200"],
      ["RIDE-104", "Customer D", "City → Hotel", "₹310"],
      ["RIDE-105", "Customer E", "Town → Mall", "₹180"],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: Text("Recent Bookings",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
        const SizedBox(height: 12),
        Container(
          height: 300,
          child: ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final b = bookings[index];
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1), blurRadius: 6)
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blueAccent.withOpacity(0.3),
                        child: const Icon(Icons.local_taxi, color: Colors.white)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(b[0],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text(b[1],
                                style:
                                const TextStyle(color: Colors.white70)),
                            Text(b[2],
                                style:
                                const TextStyle(color: Colors.white60)),
                          ]),
                    ),
                    Text(b[3],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }

  /// Generic stat card
  Widget _statCard(String title, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.9), color.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: color.withOpacity(0.3), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))
        ],
      ),
    );
  }
}
