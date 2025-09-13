import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  int _selectedIndex = 0;
  final List<String> _menuItems = [
    "Dashboard",
    "Bookings",
    "Payments",
    "Drivers",
    "Settings"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar Navigation
          Container(
            width: 220,
            color: Colors.grey.shade200,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Admin Panel",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: ListView.builder(
                    itemCount: _menuItems.length,
                    itemBuilder: (context, index) {
                      final selected = index == _selectedIndex;
                      return ListTile(
                        selected: selected,
                        selectedTileColor: Colors.blue.shade50,
                        leading: Icon(
                          _getMenuIcon(index),
                          color: selected ? Colors.blue : Colors.grey,
                        ),
                        title: Text(
                          _menuItems[index],
                          style: TextStyle(
                            color: selected ? Colors.blue : Colors.black87,
                            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          setState(() => _selectedIndex = index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: _selectedIndex == 0
                  ? _buildDashboardView()
                  : Center(child: Text("${_menuItems[_selectedIndex]} Page")),
            ),
          ),
        ],
      ),
    );
  }

  // Assign Web-safe icons
  IconData _getMenuIcon(int index) {
    switch (index) {
      case 0:
        return Icons.dashboard; // Replaced LineIcons.dashboard
      case 1:
        return Icons.list_alt;
      case 2:
        return Icons.payments;
      case 3:
        return FontAwesomeIcons.carSide; // FontAwesome car icon
      case 4:
        return Icons.settings;
      default:
        return Icons.circle;
    }
  }

  Widget _buildDashboardView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary Cards
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              _summaryCard("Total Rides", "54", Icons.local_taxi, Colors.blue),
              _summaryCard(
                  "Today Earnings", "₹1,240", Icons.account_balance_wallet, Colors.green),
              _summaryCard(
                  "Pending Payments", "₹320", Icons.error_outline, Colors.red),
              _summaryCard(
                  "Total Customers", "23", Icons.people, Colors.orange),
            ],
          ),
          const SizedBox(height: 30),

          // Earnings Chart
          const Text(
            "Earnings Trend",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: true),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(1, 1.5),
                      FlSpot(2, 3.0),
                      FlSpot(3, 2.0),
                      FlSpot(4, 3.5),
                      FlSpot(5, 4.2),
                    ],
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.blue,
                    dotData: FlDotData(show: true),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),

          // Recent Bookings Table
          const Text(
            "Recent Bookings",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          DataTable(
            headingRowColor: MaterialStateProperty.all(Colors.blue.shade50),
            columns: const [
              DataColumn(label: Text("Ride ID")),
              DataColumn(label: Text("Customer")),
              DataColumn(label: Text("Pickup")),
              DataColumn(label: Text("Drop")),
              DataColumn(label: Text("Fare")),
            ],
            rows: List.generate(
              5,
              (index) => DataRow(cells: [
                DataCell(Text("RIDE-${100 + index}")),
                DataCell(Text("Customer ${index + 1}")),
                const DataCell(Text("Station Road")),
                const DataCell(Text("Main Market")),
                const DataCell(Text("₹120")),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryCard(String title, String value, IconData icon, Color color) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
