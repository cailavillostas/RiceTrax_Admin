import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'RiceStock.dart';
import 'RiceDetailsPage.dart';

class Inventory extends StatefulWidget {
  @override
  _InventoryState createState() => _InventoryState();
}


class _InventoryState extends State<Inventory> {
  List<Map<String, dynamic>> riceData = [
    {'name': 'Dinorado', 'stock': 50},
    {'name': 'Sinandomeng', 'stock': 30},
    {'name': 'Jasmine', 'stock': 20},
    {'name': 'Well-Milled', 'stock': 45},
    {'name': 'Premium', 'stock': 60},
    {'name': 'Brown Rice', 'stock': 25},
    {'name': 'Red Rice', 'stock': 15},
    {'name': 'Glutinous', 'stock': 10},
    {'name': 'Extra Brand', 'stock': 5},
  ];

  String getStatus(int stock) {
    if (stock <= 10) return 'Out of Stock';
    if (stock <= 25) return 'Low Stock';
    return 'In Stock';
  }

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

  Icon getIcon() {
    return Icon(Icons.warehouse, color: Colors.green[800], size: 28);
  }

  void _showEditForm(BuildContext context, int index) {
    TextEditingController _nameController =
    TextEditingController(text: riceData[index]['name']);
    TextEditingController _stockController =
    TextEditingController(text: riceData[index]['stock'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: Text('Edit Brand'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Brand Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _stockController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Stock Quantity',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                String newName = _nameController.text.trim();
                int? newStock = int.tryParse(_stockController.text.trim());

                if (newName.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Brand name cannot be empty.')),
                  );
                  return;
                }

                if (newStock == null || newStock < 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid stock quantity.')),
                  );
                  return;
                }

                setState(() {
                  riceData[index]['name'] = newName;
                  riceData[index]['stock'] = newStock;
                });

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green[400]),
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAddForm(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _stockController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add New Brand',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Brand Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: _stockController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Stock',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade400),
                        ),
                      ),
                      child: Text('Cancel'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        String name = _nameController.text.trim();
                        int stock = int.tryParse(_stockController.text.trim()) ?? 0;

                        if (name.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Brand name cannot be empty.')),
                          );
                          return;
                        }

                        if (stock < 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Stock must be zero or more.')),
                          );
                          return;
                        }

                        setState(() {
                          riceData.insert(0, {'name': name, 'stock': stock});
                        });

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Add', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _deleteBrand(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Delete ${riceData[index]['name']}?'),
        content: Text('Are you sure you want to delete this brand?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                riceData.removeAt(index);
              });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required BuildContext context,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      onTap: onTap,
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
                    Text('RiceTrax',
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    Icon(Icons.menu, color: Colors.white),
                  ],
                ),
              ),
              _buildDrawerItem(icon: Icons.dashboard, title: 'Dashboard', context: context, onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Dashboard()));
              }),
              _buildDrawerItem(icon: Icons.inventory, title: 'Rice Inventory Stock', context: context, onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => RiceStock()));
              }),
              _buildDrawerItem(icon: Icons.list_alt, title: 'Inventory', context: context),
              _buildDrawerItem(icon: Icons.attach_money, title: 'Sales', context: context),
              _buildDrawerItem(icon: Icons.notifications, title: 'Notifications', context: context),
              _buildDrawerItem(icon: Icons.settings, title: 'Settings', context: context),
              _buildDrawerItem(icon: Icons.logout, title: 'Logout', context: context),
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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Inventory', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: riceData.length,
                    itemBuilder: (context, index) {
                      final item = riceData[index];
                      final status = getStatus(item['stock']);

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RiceDetailsPage(
                              brandName: item['name'],
                              stock: item['stock'],
                              status: status,
                            ),
                          ),
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                          margin: EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.green.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: getIcon(),
                                    ),
                                    SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                        SizedBox(height: 4),
                                        Text('${item['stock']} sacks'),
                                        SizedBox(height: 4),
                                        Container(
                                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: getBadgeColor(status),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(status, style: TextStyle(fontSize: 12)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Tooltip(
                                      message: 'Edit Brand',
                                      child: IconButton(
                                        icon: Icon(Icons.edit, color: Colors.green),
                                        onPressed: () => _showEditForm(context, index),
                                      ),
                                    ),
                                    Tooltip(
                                      message: 'Delete Brand',
                                      child: IconButton(
                                        icon: Icon(Icons.delete, color: Colors.redAccent),
                                        onPressed: () => _deleteBrand(index),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 70),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () => _showAddForm(context),
                icon: Icon(Icons.add, size: 20, color: Colors.green[800]),
                label: Text(
                  'Add Brand',
                  style: TextStyle(color: Colors.green[800], fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 2,
                  side: BorderSide(color: Colors.green[800]!, width: 2),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
