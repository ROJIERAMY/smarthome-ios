import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _users = [];
  final List<Map<String, dynamic>> _devices = [];
  final List<Map<String, dynamic>> _logs = [];

  @override
  void initState() {
    super.initState();
    _loadSampleData();
  }

  void _loadSampleData() {
    // Sample users data
    _users.addAll([
      {
        'name': 'John Doe',
        'email': 'john@example.com',
        'role': 'user',
        'lastLogin': '2024-01-15 10:30',
        'status': 'active',
      },
      {
        'name': 'Jane Smith',
        'email': 'jane@example.com',
        'role': 'admin',
        'lastLogin': '2024-01-15 09:15',
        'status': 'active',
      },
      {
        'name': 'Bob Wilson',
        'email': 'bob@example.com',
        'role': 'user',
        'lastLogin': '2024-01-14 16:45',
        'status': 'inactive',
      },
    ]);

    // Sample devices data
    _devices.addAll([
      {
        'name': 'Smart Light 1',
        'type': 'Light',
        'location': 'Living Room',
        'status': 'online',
        'lastSeen': '2 minutes ago',
      },
      {
        'name': 'Security Camera 1',
        'type': 'Camera',
        'location': 'Front Door',
        'status': 'online',
        'lastSeen': '1 minute ago',
      },
      {
        'name': 'Smart Thermostat',
        'type': 'Thermostat',
        'location': 'Bedroom',
        'status': 'offline',
        'lastSeen': '1 hour ago',
      },
    ]);

    // Sample logs data
    _logs.addAll([
      {
        'timestamp': '2024-01-15 10:30:15',
        'user': 'John Doe',
        'action': 'Turned on lights',
        'device': 'Smart Light 1',
        'status': 'success',
      },
      {
        'timestamp': '2024-01-15 10:25:42',
        'user': 'Jane Smith',
        'action': 'Changed temperature',
        'device': 'Smart Thermostat',
        'status': 'success',
      },
      {
        'timestamp': '2024-01-15 10:20:18',
        'user': 'Bob Wilson',
        'action': 'Failed login attempt',
        'device': 'System',
        'status': 'failed',
      },
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red.shade700,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 250,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildSidebarItem(0, Icons.dashboard, 'Overview'),
                _buildSidebarItem(1, Icons.people, 'Users'),
                _buildSidebarItem(2, Icons.devices, 'Devices'),
                _buildSidebarItem(3, Icons.history, 'Activity Logs'),
                _buildSidebarItem(4, Icons.settings, 'Settings'),
              ],
            ),
          ),
          // Main content
          Expanded(
            child: _buildMainContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem(int index, IconData icon, String title) {
    final isSelected = _selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.red.shade700 : Colors.grey.shade600,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.red.shade700 : Colors.grey.shade600,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        selectedTileColor: Colors.red.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildMainContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildOverview();
      case 1:
        return _buildUsers();
      case 2:
        return _buildDevices();
      case 3:
        return _buildActivityLogs();
      case 4:
        return _buildSettings();
      default:
        return _buildOverview();
    }
  }

  Widget _buildOverview() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'System Overview',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          // Stats Cards
          Row(
            children: [
              Expanded(child: _buildStatCard('Total Users', '${_users.length}', Icons.people, Colors.blue)),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard('Active Devices', '${_devices.where((d) => d['status'] == 'online').length}', Icons.devices, Colors.green)),
              const SizedBox(width: 16),
              Expanded(child: _buildStatCard('System Uptime', '99.9%', Icons.timer, Colors.orange)),
            ],
          ),
          const SizedBox(height: 30),
          // Recent Activity
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: _logs.take(5).length,
                itemBuilder: (context, index) {
                  final log = _logs[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: log['status'] == 'success' ? Colors.green : Colors.red,
                      child: Icon(
                        log['status'] == 'success' ? Icons.check : Icons.error,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title: Text(log['action']),
                    subtitle: Text('${log['user']} - ${log['timestamp']}'),
                    trailing: Text(
                      log['device'],
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsers() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'User Management',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Add new user functionality
                },
                icon: const Icon(Icons.add),
                label: const Text('Add User'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Role')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Last Login')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: _users.map((user) {
                  return DataRow(
                    cells: [
                      DataCell(Text(user['name'])),
                      DataCell(Text(user['email'])),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: user['role'] == 'admin' ? Colors.red.shade100 : Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            user['role'].toUpperCase(),
                            style: TextStyle(
                              color: user['role'] == 'admin' ? Colors.red.shade700 : Colors.blue.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: user['status'] == 'active' ? Colors.green.shade100 : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            user['status'].toUpperCase(),
                            style: TextStyle(
                              color: user['status'] == 'active' ? Colors.green.shade700 : Colors.grey.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(user['lastLogin'])),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, size: 18),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDevices() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Device Management',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.5,
              ),
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final device = _devices[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _getDeviceIcon(device['type']),
                            color: device['status'] == 'online' ? Colors.green : Colors.red,
                            size: 24,
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: device['status'] == 'online' ? Colors.green.shade100 : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              device['status'].toUpperCase(),
                              style: TextStyle(
                                color: device['status'] == 'online' ? Colors.green.shade700 : Colors.red.shade700,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        device['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        device['location'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Last seen: ${device['lastSeen']}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityLogs() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Activity Logs',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final log = _logs[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: log['status'] == 'success' ? Colors.green : Colors.red,
                      child: Icon(
                        log['status'] == 'success' ? Icons.check : Icons.error,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    title: Text(log['action']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('User: ${log['user']}'),
                        Text('Device: ${log['device']}'),
                        Text('Time: ${log['timestamp']}'),
                      ],
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: log['status'] == 'success' ? Colors.green.shade100 : Colors.red.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        log['status'].toUpperCase(),
                        style: TextStyle(
                          color: log['status'] == 'success' ? Colors.green.shade700 : Colors.red.shade700,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettings() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'System Settings',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ListView(
                children: [
                  _buildSettingItem('System Maintenance', 'Schedule maintenance windows', Icons.build),
                  _buildSettingItem('Security Settings', 'Configure security policies', Icons.security),
                  _buildSettingItem('Backup Settings', 'Manage data backups', Icons.backup),
                  _buildSettingItem('Notifications', 'Configure system notifications', Icons.notifications),
                  _buildSettingItem('API Settings', 'Manage API access', Icons.api),
                  _buildSettingItem('Database Settings', 'Database configuration', Icons.storage),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, String subtitle, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.red.shade700),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // Handle setting item tap
      },
    );
  }

  IconData _getDeviceIcon(String type) {
    switch (type.toLowerCase()) {
      case 'light':
        return Icons.lightbulb;
      case 'camera':
        return Icons.videocam;
      case 'thermostat':
        return Icons.thermostat;
      default:
        return Icons.device_hub;
    }
  }
}
