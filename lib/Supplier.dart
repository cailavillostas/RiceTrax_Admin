import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'Inventory.dart';
import 'NotificationsPage.dart';
import 'RiceStock.dart';

class SupplierPage extends StatefulWidget {
  @override
  _SupplierPageState createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  List<Map<String, dynamic>> batchData = [
    {'name': 'Agro Supply Co.', 'quantity': 100, 'date': '2025-07-01', 'cost': 5000.0},
    {'name': 'RiceGrower Inc.', 'quantity': 200, 'date': '2025-07-08', 'cost': 10200.0},
    {'name': 'Harvest Partners', 'quantity': 150, 'date': '2025-07-12', 'cost': 7500.0},
  ];

  void _editBatch(int index) {
    final item = batchData[index];
    final nameController = TextEditingController(text: item['name']);
    final quantityController = TextEditingController(text: item['quantity'].toString());
    final dateController = TextEditingController(text: item['date']);
    final costController = TextEditingController(text: item['cost'].toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.green[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Edit Batch', style: TextStyle(color: Colors.green[900], fontWeight: FontWeight.bold)),
        content: Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildInputField(nameController, 'Supplier Name'),
                SizedBox(height: 10),
                _buildInputField(quantityController, 'Quantity (kg)', isNumber: true),
                SizedBox(height: 10),
                _buildInputField(dateController, 'Date Purchased'),
                SizedBox(height: 10),
                _buildInputField(costController, 'Total Cost (₱)', isNumber: true),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                batchData[index] = {
                  'name': nameController.text,
                  'quantity': int.tryParse(quantityController.text) ?? 0,
                  'date': dateController.text,
                  'cost': double.tryParse(costController.text) ?? 0.0,
                };
              });
              Navigator.pop(context);
            },
            child: Text('Save', style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label, {bool isNumber = false}) {
    return TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green[900]),
    filled: true,
    fillColor: Colors.white,
    focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.green),
    borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade300),
    borderRadius: BorderRadius.circular(8),
    ),
    ),
    );
  }

  void _deleteBatch(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Confirm Delete'),
        content: Text('Are you sure you want to delete this batch?'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                batchData.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text('Yes', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String title, required BuildContext context, required Widget page}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      onTap: () {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }

  DataRow _buildDataRow(int index, Map<String, dynamic> item) {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) => index % 2 == 0 ? Colors.white : Colors.green.shade50),
      cells: [
        DataCell(Text(item['name'])),
        DataCell(Text('${item['quantity']} kg')),
        DataCell(Text(item['date'])),
        DataCell(Text('₱${item['cost'].toStringAsFixed(2)}')),
        DataCell(Row(
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editBatch(index),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteBatch(index),
            ),
          ],
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Colors.green[800],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.green[900]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('RiceTrax', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    Icon(Icons.menu, color: Colors.white),
                  ],
                ),
              ),
              _buildDrawerItem(icon: Icons.dashboard, title: 'Dashboard', context: context, page: Dashboard()),
              _buildDrawerItem(icon: Icons.inventory, title: 'Rice Inventory Stock', context: context, page: RiceStock()),
              _buildDrawerItem(icon: Icons.list_alt, title: 'Inventory', context: context, page: Inventory()),
              _buildDrawerItem(icon: Icons.person, title: 'Supplier', context: context, page: SupplierPage()),
              _buildDrawerItem(icon: Icons.attach_money, title: 'Sales', context: context, page: Inventory()),
              _buildDrawerItem(icon: Icons.notifications, title: 'Notifications', context: context, page: NotificationsPage()),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text('Settings', style: TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text('Logout', style: TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('RiceTrax', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Supplier Management', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Batch Purchases', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    side: BorderSide(color: Colors.black),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text('+ Add Batch', style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
              ],
            ),
            SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith((states) => Colors.green.shade100),
                  columns: const [
                    DataColumn(label: Text('Supplier Name', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Quantity (kg)', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Date Purchased', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Total Cost (₱)', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: List.generate(batchData.length, (index) => _buildDataRow(index, batchData[index])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}