import 'package:flutter/material.dart';

class RiceDetailsPage extends StatelessWidget {
  final String brandName;
  final int stock;
  final String status;

  const RiceDetailsPage({
    super.key,
    required this.brandName,
    required this.stock,
    required this.status,
  });

  Color getBadgeColor(String status) {
    switch (status) {
      case 'In Stock':
        return Colors.green.shade200;
      case 'Low Stock':
        return Colors.yellow.shade600;
      case 'Out of Stock':
        return Colors.red.shade300;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Sample Data
    int soldStock = 90;
    int pricePerSack = 1800;

    List<Map<String, dynamic>> transactions = [
      {'id': 'T001', 'date': '2025-05-01', 'qty': 20, 'unitPrice': 45},
      {'id': 'T002', 'date': '2025-05-03', 'qty': 15, 'unitPrice': 45},
      {'id': 'T003', 'date': '2025-05-10', 'qty': 15, 'unitPrice': 45},
      {'id': 'T050', 'date': '2025-05-15', 'qty': 30, 'unitPrice': 45},
      {'id': 'T051', 'date': '2025-05-20', 'qty': 20, 'unitPrice': 45},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('$brandName Details'),
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: [
            // Summary Boxes
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSummaryBox('Total Stock', '$stock sacks', Colors.green.shade100),
              _buildSummaryBox('Sold Stock', '$soldStock sacks', Colors.orange.shade100),
              _buildSummaryBox('Price/Sack', '₱$pricePerSack', Colors.blue.shade100),
            ],
          ),
          SizedBox(height: 24),

          // Filters
          Row(
            children: [
              _buildDropdown('Year', ['All Years', '2025'], 'All Years'),
              SizedBox(width: 16),
              _buildDropdown('Month', ['All Months', 'May'], 'All Months'),
              Spacer(),
              ElevatedButton(
                onPressed: () {},
                child: Text('Download Excel'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[800],
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          // Table Header
          Container(
              color: Colors.green[800],
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: Row(
                  children: [
                    _buildHeaderCell('Transaction ID', flex: 2),
                    _buildHeaderCell('Date', flex: 2),
                    _buildHeaderCell('Quantity (kg)', flex: 2),
                    _buildHeaderCell('Unit Price (₱)', flex: 2),
                    _buildHeaderCell('Total (₱)', flex: 2),
                  ],
                ),
              ),

              // Table Rows
              ...transactions.map((tx) {
      double total = tx['qty'] * tx['unitPrice'].toDouble();
      return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
      children: [
      _buildDataCell(tx['id'], flex: 2),
      _buildDataCell(tx['date'], flex: 2),
      _buildDataCell('${tx['qty']}', flex: 2),
      _buildDataCell('${tx['unitPrice']}', flex: 2),
      _buildDataCell('${total.toStringAsFixed(2)}', flex: 2),
      ],
      ),
      );
      }),
      ],
    ),
    ),
    );
  }

  // Reusable summary box
  Widget _buildSummaryBox(String title, String value, Color bgColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
            children: [
            Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // Dropdown filter builder
  Widget _buildDropdown(String label, List<String> items, String selected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 4),
        DropdownButton<String>(
          value: selected,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: (value) {},
        ),
      ],
    );
  }

  // Table headers
  Widget _buildHeaderCell(String title, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Table data
  Widget _buildDataCell(String value, {required int flex}) {
    return Expanded(
      flex: flex,
      child: Text(value),
    );
  }
}