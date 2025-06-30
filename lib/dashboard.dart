import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('RiceTrax'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _showTopMenu(context),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16),

          _buildDashboardCard(title: 'Total Sales Today'),
          SizedBox(height: 16),

          _buildDashboardCard(title: 'Total Stock (sacks)'),
          SizedBox(height: 16),

          _buildDashboardCard(title: 'Sold Stocks (sacks)'),
          SizedBox(height: 16),

          _buildDashboardCard(title: 'Low Stocks'),
        ],
      ),
    );
  }

  Widget _buildDashboardCard({required String title}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }

  void _showTopMenu(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Menu',
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.white,
            elevation: 8,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMenuItem(context, icon: Icons.dashboard, title: 'Dashboard'),
                  _buildMenuItem(context, icon: Icons.inventory, title: 'Inventory'),
                  _buildMenuItem(context, icon: Icons.attach_money, title: 'Sales'),
                  _buildMenuItem(context, icon: Icons.notifications, title: 'Notifications'),
                  _buildMenuItem(context, icon: Icons.local_shipping, title: 'Supplier'),
                  _buildMenuItem(context, icon: Icons.settings, title: 'Settings'),
                  Divider(),
                  _buildMenuItem(context, icon: Icons.logout, title: 'Logout'),
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String title}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }
}