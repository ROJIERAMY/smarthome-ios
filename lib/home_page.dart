import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_provider.dart';
import 'admin_dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _lightsOn = false;
  bool _fanOn = false;
  bool _acOn = false;
  bool _securityOn = true;
  double _temperature = 22.0;
  int _brightness = 50;

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          backgroundColor: Colors.grey.shade100,
          appBar: AppBar(
            title: Text(
              'Welcome, ${authProvider.userData?['name'] ?? 'User'}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.blue.shade700,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.admin_panel_settings),
                onPressed: () {
                  if (authProvider.isAdmin) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminDashboard(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Admin access required'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () async {
                  await authProvider.logout();
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Status Card
                _buildStatusCard(),
                const SizedBox(height: 20),
                
                // Quick Controls
                _buildQuickControls(),
                const SizedBox(height: 20),
                
                // Smart Devices Grid
                _buildSmartDevicesGrid(),
                const SizedBox(height: 20),
                
                // Temperature Control
                _buildTemperatureControl(),
                const SizedBox(height: 20),
                
                // Security Status
                _buildSecurityStatus(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade600, Colors.blue.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Smart Home Status',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'All systems operational',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              _buildStatusIndicator('Lights', _lightsOn),
              const SizedBox(width: 20),
              _buildStatusIndicator('Fan', _fanOn),
              const SizedBox(width: 20),
              _buildStatusIndicator('AC', _acOn),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIndicator(String label, bool isOn) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isOn ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickControls() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Controls',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _buildControlCard(
                'Lights',
                Icons.lightbulb_outline,
                _lightsOn,
                () => setState(() => _lightsOn = !_lightsOn),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildControlCard(
                'Fan',
                Icons.ac_unit,
                _fanOn,
                () => setState(() => _fanOn = !_fanOn),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildControlCard(
                'AC',
                Icons.air,
                _acOn,
                () => setState(() => _acOn = !_acOn),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildControlCard(String title, IconData icon, bool isOn, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isOn ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isOn ? Colors.blue.shade300 : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isOn ? Colors.blue.shade600 : Colors.grey.shade600,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isOn ? Colors.blue.shade600 : Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isOn ? 'ON' : 'OFF',
              style: TextStyle(
                fontSize: 12,
                color: isOn ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartDevicesGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Smart Devices',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _buildDeviceCard('Smart TV', Icons.tv, 'Living Room', true),
            _buildDeviceCard('Security Camera', Icons.videocam, 'Front Door', _securityOn),
            _buildDeviceCard('Smart Speaker', Icons.speaker, 'Bedroom', true),
            _buildDeviceCard('Smart Lock', Icons.lock, 'Main Door', true),
          ],
        ),
      ],
    );
  }

  Widget _buildDeviceCard(String name, IconData icon, String location, bool isConnected) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 24,
                color: isConnected ? Colors.green : Colors.grey,
              ),
              const Spacer(),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isConnected ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            location,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureControl() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          const Text(
            'Temperature Control',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(
                Icons.thermostat,
                size: 32,
                color: Colors.blue.shade600,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_temperature.toStringAsFixed(1)}°C',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Slider(
                      value: _temperature,
                      min: 16.0,
                      max: 30.0,
                      divisions: 28,
                      activeColor: Colors.blue.shade600,
                      onChanged: (value) {
                        setState(() {
                          _temperature = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildBrightnessControl(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBrightnessControl() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.brightness_6,
              size: 20,
              color: Colors.orange.shade600,
            ),
            const SizedBox(width: 8),
            Text(
              'Brightness: $_brightness%',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        Slider(
          value: _brightness.toDouble(),
          min: 0.0,
          max: 100.0,
          divisions: 20,
          activeColor: Colors.orange.shade600,
          onChanged: (value) {
            setState(() {
              _brightness = value.round();
            });
          },
        ),
      ],
    );
  }

  Widget _buildSecurityStatus() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _securityOn ? Colors.green.shade50 : Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _securityOn ? Colors.green.shade300 : Colors.red.shade300,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.security,
            size: 32,
            color: _securityOn ? Colors.green.shade600 : Colors.red.shade600,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Security System',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _securityOn ? Colors.green.shade700 : Colors.red.shade700,
                  ),
                ),
                Text(
                  _securityOn ? 'Armed and Protected' : 'Disarmed',
                  style: TextStyle(
                    fontSize: 14,
                    color: _securityOn ? Colors.green.shade600 : Colors.red.shade600,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _securityOn,
            onChanged: (value) {
              setState(() {
                _securityOn = value;
              });
            },
            activeColor: Colors.green.shade600,
          ),
        ],
      ),
    );
  }
}


