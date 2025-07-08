import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'Inventory.dart';

class RiceStock extends StatelessWidget {
  final List<List<String>> data = [
    ['Name', 'Stock', 'Sold', 'Price', 'Status'],
    ['Maharlika', '54', '15', '₱58', 'In Stock'],
    ['Dinorado', '45', '10', '₱59', 'In Stock'],
    ['Jasmin', '40', '10', '₱55', 'In Stock'],
    ['Angelika', '30', '10', '₱56', 'Low Stock'],
    ['Sinandomeng', '0', '9', '₱54', 'Out of Stock'],
    ['Malagkit', '25', '5', '₱62', 'Low Stock'],
    ['Intan', '0', '12', '₱57', 'Out of Stock'],
    ['Blue Dragon', '12', '3', '₱60', 'Low Stock'],
    ['Golden Queen', '65', '20', '₱61', 'In Stock'],
    ['Red Rice', '0', '7', '₱66', 'Out of Stock'],
    ['Black Rice', '18', '8', '₱70', 'Low Stock'],
    ['Organic Brown', '22', '4', '₱64', 'In Stock'],
    ['Japanese Rice', '55', '15', '₱72', 'In Stock'],
    ['Sinandomeng', '35', '10', '₱54', 'In Stock'],
    ['Well-Milled Rice', '29', '13', '₱59', 'Low Stock'],
    ['Milagrosa', '60', '11', '₱60', 'In Stock'],
    ['Dinorado', '28', '6', '₱59', 'Low Stock'],
    ['Malagkit', '0', '5', '₱62', 'Out of Stock'],
  ];

  @override
  Widget build(BuildContext context) {
    int lowStockCount = data
        .skip(1)
        .where((row) => row.last == 'Low Stock')
        .length;

    int outOfStockCount = data
        .skip(1)
        .where((row) => row.last == 'Out of Stock')
        .length;

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
                    Text(
                      'RiceTrax',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.menu, color: Colors.white),
                  ],
                ),
              ),
              _buildDrawerItem(
                icon: Icons.dashboard,
                title: 'Dashboard',
                context: context,
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Dashboard()),
                ),
              ),
              _buildDrawerItem(
                icon: Icons.inventory,
                title: 'Rice Inventory Stock',
                context: context,
                onTap: () {},
              ),
              _buildDrawerItem(
                icon: Icons.list_alt,
                title: 'Inventory',
                context: context,
                onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Inventory()),
                ),
              ),
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
        title: Center(
          child: Text(
            'Rice Inventory Stock',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8.0),
            child: Card(
              color: Colors.orange[100],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.warning, color: Colors.orange[900], size: 36),
                title: Text(
                  'Low Stock Items',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange[900],
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '$lowStockCount item(s) low on stock',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.orange[800],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8.0),
            child: Card(
              color: Colors.red[100],
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Icon(Icons.error, color: Colors.red[900], size: 36),
                title: Text(
                  'Out of Stock Items',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900],
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '$outOfStockCount item(s) out of stock',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.red[800],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Table(
                    border: TableBorder.all(color: Colors.black, width: 1),
                    defaultColumnWidth: FixedColumnWidth(120),
                    children: data.map((row) {
                      bool isHeader = row == data.first;
                      Color? rowColor;
                      if (!isHeader) {
                        String status = row[4];
                        if (status == 'Low Stock') {
                          rowColor = Colors.orange[100];
                        } else if (status == 'Out of Stock') {
                          rowColor = Colors.red[100];
                        }
                      }
                      return TableRow(
                        decoration: BoxDecoration(
                          color: isHeader ? Colors.grey[300] : rowColor,
                        ),
                        children: row.map((cell) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              cell,
                              style: TextStyle(
                                fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }).toList(),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
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
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      onTap: onTap ?? () {},
    );
  }
}
