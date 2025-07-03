import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // pubspec: fl_chart: ^0.60.0
import 'RiceStock.dart'; // adjust path if needed

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer( // ✅ Drawer now on the right
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[800],
              ),
              child: Text(
                'RiceTrax Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard, color: Colors.green[800]),
              title: Text('Dashboard'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: Icon(Icons.inventory, color: Colors.green[800]),
              title: Text('Rice Inventory'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RiceStock()),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        title: Text('RiceTrax'),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openEndDrawer(); // ✅ Open right drawer
              },
            ),
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
              color: Colors.green[800],
            ),
          ),
          SizedBox(height: 16),

          _buildDashboardCard(
            icon: Icons.attach_money,
            title: 'Total Sales Today',
            value: '₱ 15,400',
          ),
          SizedBox(height: 16),

          _buildDashboardCard(
            icon: Icons.inventory_2,
            title: 'Total Stock (sacks)',
            value: '930',
          ),
          SizedBox(height: 16),

          _buildDashboardCard(
            icon: Icons.shopping_cart,
            title: 'Sold Stocks (sacks)',
            value: '250',
          ),
          SizedBox(height: 16),

          _buildDashboardCard(
            icon: Icons.warning,
            title: 'Low Stocks',
            value: '1 item',
          ),
          SizedBox(height: 24),

          _buildSectionTitle('Inventory Breakdown (sacks)'),
          SizedBox(height: 200, child: _buildPieChart()),
          SizedBox(height: 24),

          _buildSectionTitle('Monthly Sales (₱)'),
          SizedBox(height: 200, child: _buildBarChart()),

          SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RiceStock()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800],
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'View Rice Inventory Stock',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.green[800], size: 28),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16)),
                SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.green[800],
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 400,
            title: '400',
            color: Colors.green,
            radius: 60,
          ),
          PieChartSectionData(
            value: 300,
            title: '300',
            color: Colors.green[300],
            radius: 60,
          ),
          PieChartSectionData(
            value: 80,
            title: '80',
            color: Colors.green[100],
            radius: 60,
          ),
        ],
        sectionsSpace: 2,
        centerSpaceRadius: 0,
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 24,
              getTitlesWidget: (value, _) {
                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
                return Text(months[value.toInt() % months.length],
                    style: TextStyle(fontSize: 12));
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, _) => Text(
                '${value.toInt()}',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 400, color: Colors.green)]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 300, color: Colors.green)]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 500, color: Colors.green)]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 200, color: Colors.green)]),
          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 300, color: Colors.green)]),
        ],
      ),
    );
  }
}
