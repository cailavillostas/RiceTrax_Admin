import 'package:flutter/material.dart';
import 'Dashboard.dart';
import 'Inventory.dart';
import 'RiceStock.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'message': 'Jasmine is Low Stock',
      'datetime': '2025-07-14   09:45 AM'
    },
    {
      'message': 'Well-Milled is Out of Stock',
      'datetime': '2025-07-13   09:30 AM'
    },
    {
      'message': 'Brown Rice is Low Stock',
      'datetime': '2025-07-13   05:10 PM'
    },
    {
      'message': 'Glutinous is Low Stock',
      'datetime': '2025-07-12   04:00 PM'
    },
    {
      'message': 'Extra Brand is Out of Stock',
      'datetime': '2025-07-11   03:25 PM'
    },
  ];

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
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                    Icon(Icons.menu, color: Colors.white),
                  ],
                ),
              ),
              _buildDrawerItem(
                  icon: Icons.dashboard,
                  title: 'Dashboard',
                  context: context,
                  page: Dashboard()),
              _buildDrawerItem(
                  icon: Icons.inventory,
                  title: 'Rice Inventory Stock',
                  context: context,
                  page: RiceStock()),
              _buildDrawerItem(
                  icon: Icons.list_alt,
                  title: 'Inventory',
                  context: context,
                  page: Inventory()),
              _buildDrawerItem(
                  icon: Icons.person,
                  title: 'Supplier',
                  context: context,
                  page: Inventory()),
              _buildDrawerItem(
                  icon: Icons.attach_money,
                  title: 'Sales',
                  context: context,
                  page: Inventory()),
              _buildDrawerItem(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  context: context,
                  page: NotificationsPage()),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text('Settings',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text('Logout',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('RiceTrax',
            style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
            Text('Product Notifications',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      leading: Icon(Icons.notifications_active,
                          color: Colors.green[800]),
                      title: Text(item['message'] ?? ''),
                      subtitle: Text(item['datetime'] ?? '',
                          style: TextStyle(color: Colors.grey[600])),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required BuildContext context,
    required Widget page,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title:
      Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}