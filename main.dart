import 'package:flutter/material.dart';

void main() {
  runApp(const PathIQApp());
}

class PathIQApp extends StatelessWidget {
  const PathIQApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PathIQ AI Safety App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A5276)),
        useMaterial3: true,
      ),
      home: const AuthScreen(),
    );
  }
}

// ==========================================
// SCREEN 1: AUTH SCREEN
// ==========================================
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isUserRole = true;
  bool isLoginMode = true;

  final _formKey = GlobalKey<FormState>();
  final _emailPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _vehicleNoController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _vehicleCountController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final roleText = isUserRole ? 'User' : 'Fleet Manager';
      final actionText = isLoginMode ? 'Logged in' : 'Signed up';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$actionText successfully as $roleText!'),
          backgroundColor: Colors.green,
        ),
      );

      if (isUserRole) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const UserMainWrapper()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FleetDashboardScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.shield_outlined,
                      size: 50,
                      color: Color(0xFF1A5276),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'PathIQ AI',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A5276),
                      ),
                    ),
                    const Text(
                      'Honda Bharat Safety Program',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment<bool>(
                          value: true,
                          label: Text('Rider / User'),
                          icon: Icon(Icons.two_wheeler),
                        ),
                        ButtonSegment<bool>(
                          value: false,
                          label: Text('Fleet Manager'),
                          icon: Icon(Icons.business),
                        ),
                      ],
                      selected: {isUserRole},
                      onSelectionChanged: (Set<bool> newSelection) {
                        setState(() => isUserRole = newSelection.first);
                      },
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ChoiceChip(
                          label: const Text('Login'),
                          selected: isLoginMode,
                          onSelected: (selected) {
                            if (selected) setState(() => isLoginMode = true);
                          },
                        ),
                        const SizedBox(width: 12),
                        ChoiceChip(
                          label: const Text('Sign Up'),
                          selected: !isLoginMode,
                          onSelected: (selected) {
                            if (selected) setState(() => isLoginMode = false);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    if (isUserRole) ...[
                      if (!isLoginMode) ...[
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) => val == null || val.isEmpty
                              ? 'Please enter your name'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _vehicleNoController,
                          decoration: const InputDecoration(
                            labelText: 'Vehicle Number',
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) => val == null || val.isEmpty
                              ? 'Please enter vehicle number'
                              : null,
                        ),
                        const SizedBox(height: 12),
                      ],
                      TextFormField(
                        controller: _emailPhoneController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number or Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) => val == null || val.isEmpty
                            ? 'Please enter phone or email'
                            : null,
                      ),
                      const SizedBox(height: 12),
                    ] else ...[
                      if (!isLoginMode) ...[
                        TextFormField(
                          controller: _companyNameController,
                          decoration: const InputDecoration(
                            labelText: 'Company / Fleet Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) => val == null || val.isEmpty
                              ? 'Please enter company name'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _vehicleCountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Total Fleet Vehicles',
                            border: OutlineInputBorder(),
                          ),
                          validator: (val) => val == null || val.isEmpty
                              ? 'Please enter vehicle count'
                              : null,
                        ),
                        const SizedBox(height: 12),
                      ],
                      TextFormField(
                        controller: _emailPhoneController,
                        decoration: const InputDecoration(
                          labelText: 'Manager Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (val) => val == null || val.isEmpty
                            ? 'Please enter manager email'
                            : null,
                      ),
                      const SizedBox(height: 12),
                    ],

                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (val) => val == null || val.length < 4
                          ? 'Password must be at least 4 chars'
                          : null,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Reset link sent')),
                          );
                        },
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1A5276),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: _submitForm,
                        child: Text(
                          isLoginMode ? 'LOGIN' : 'CREATE ACCOUNT',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// RIDER MAIN WRAPPER (BOTTOM NAVIGATION)
// ==========================================
class UserMainWrapper extends StatefulWidget {
  const UserMainWrapper({super.key});

  @override
  State<UserMainWrapper> createState() => _UserMainWrapperState();
}

class _UserMainWrapperState extends State<UserMainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const UserHomeScreen(),
    const ReportHazardScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF1A5276),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Home Map'),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_amber_rounded),
            label: 'Report Hazard',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// ==========================================
// SCREEN 2: RIDER LIVE MAP DASHBOARD
// ==========================================
class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  bool isDetectionActive = true;
  bool showAlert = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rider Live Map',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1A5276),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.blueGrey[100],
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(width: 120, color: Colors.grey[700]),
                  Container(
                    width: 4,
                    color: Colors.yellow,
                    height: double.infinity,
                  ),
                  const Positioned(
                    top: 150,
                    child: Chip(
                      avatar: Icon(Icons.warning, color: Colors.red),
                      label: Text('Pothole Detected (200m)'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const Positioned(
                    bottom: 180,
                    child: Chip(
                      avatar: Icon(Icons.water_drop, color: Colors.blue),
                      label: Text('Waterlogging (500m)'),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const Positioned(
                    bottom: 80,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Color(0xFF1A5276),
                      child: Icon(
                        Icons.two_wheeler,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isDetectionActive = !isDetectionActive;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isDetectionActive ? Colors.green : Colors.red,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 4),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isDetectionActive
                              ? Icons.videocam
                              : Icons.videocam_off,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isDetectionActive ? 'Detection Active' : 'Camera Off',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 4),
                    ],
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.speed, color: Color(0xFF1A5276), size: 18),
                      SizedBox(width: 6),
                      Text(
                        '32 km/h',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showAlert)
            Positioned(
              top: 75,
              left: 16,
              right: 16,
              child: Card(
                color: Colors.red[600],
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'HAZARD ALERT!',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Pothole detected 200m ahead',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => setState(() => showAlert = false),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 20,
            right: 16,
            child: FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  showAlert = true;
                });
              },
              backgroundColor: Colors.orange[800],
              icon: const Icon(Icons.add_alert, color: Colors.white),
              label: const Text(
                'Simulate Alert',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// SCREEN 3: REPORT HAZARD SCREEN
// ==========================================
class ReportHazardScreen extends StatefulWidget {
  const ReportHazardScreen({super.key});

  @override
  State<ReportHazardScreen> createState() => _ReportHazardScreenState();
}

class _ReportHazardScreenState extends State<ReportHazardScreen> {
  String selectedType = 'Pothole';
  String selectedSeverity = 'Medium';
  bool isPhotoAttached = false;

  final List<String> hazardTypes = [
    'Pothole',
    'Waterlogging',
    'Speed Breaker',
    'Debris',
    'Other',
  ];
  final List<String> severityLevels = ['Low', 'Medium', 'High'];

  void _submitReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Hazard ($selectedType) reported successfully! Thank you for keeping roads safe.',
        ),
        backgroundColor: Colors.green,
      ),
    );

    setState(() {
      selectedType = 'Pothole';
      selectedSeverity = 'Medium';
      isPhotoAttached = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Report Road Hazard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1A5276),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hazard Type',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: hazardTypes.map((type) {
                return ChoiceChip(
                  label: Text(type),
                  selected: selectedType == type,
                  selectedColor: const Color(0xFF1A5276).withOpacity(0.2),
                  onSelected: (selected) {
                    if (selected) setState(() => selectedType = type);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            const Text(
              'Location',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: 'Lat: 28.6139, Long: 77.2090 (Current Location)',
              readOnly: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.location_on, color: Colors.red),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Color(0xFFF2F4F4),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Severity Level',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: severityLevels.map((level) {
                return ButtonSegment<String>(value: level, label: Text(level));
              }).toList(),
              selected: {selectedSeverity},
              onSelectionChanged: (Set<String> newSelection) {
                setState(() {
                  selectedSeverity = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 20),

            const Text(
              'Photo Attachment',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  isPhotoAttached = !isPhotoAttached;
                });
              },
              icon: Icon(
                isPhotoAttached ? Icons.check_circle : Icons.camera_alt,
                color: isPhotoAttached ? Colors.green : const Color(0xFF1A5276),
              ),
              label: Text(
                isPhotoAttached
                    ? 'Photo Attached (hazard_image.jpg)'
                    : 'Attach Road Photo',
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A5276),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _submitReport,
                child: const Text(
                  'SUBMIT HAZARD REPORT',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Simple Profile
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rider Profile'),
        backgroundColor: const Color(0xFF1A5276),
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 40, child: Icon(Icons.person, size: 50)),
            SizedBox(height: 12),
            Text(
              'Rahul Sharma',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Vehicle: DL 01 AB 1234',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// SCREEN 4: FLEET MANAGER DASHBOARD
// ==========================================
class FleetDashboardScreen extends StatefulWidget {
  const FleetDashboardScreen({super.key});

  @override
  State<FleetDashboardScreen> createState() => _FleetDashboardScreenState();
}

class _FleetDashboardScreenState extends State<FleetDashboardScreen> {
  // Dummy Fleet Data
  final List<Map<String, String>> fleetRiders = [
    {
      'name': 'Rahul Sharma',
      'status': 'Riding',
      'camera': 'Active',
      'vehicle': 'DL 01 AB 1234',
      'location': 'Connaught Place, New Delhi',
      'reports': '2 Hazards (Potholes)',
    },
    {
      'name': 'Aman Verma',
      'status': 'Idle',
      'camera': 'Off',
      'vehicle': 'DL 04 CD 5678',
      'location': 'Sector 18, Noida',
      'reports': '0 Hazards',
    },
    {
      'name': 'Priya Singh',
      'status': 'Riding',
      'camera': 'Active',
      'vehicle': 'HR 26 EF 9012',
      'location': 'Cyber City, Gurugram',
      'reports': '1 Hazard (Waterlogging)',
    },
    {
      'name': 'Vikram Patel',
      'status': 'Offline',
      'camera': 'Off',
      'vehicle': 'UP 16 GH 3456',
      'location': 'Indirapuram, Ghaziabad',
      'reports': '3 Hazards',
    },
  ];

  void _showRiderDetails(Map<String, String> rider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Color(0xFF1A5276),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rider['name']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Vehicle: ${rider['vehicle']}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 24),
              ListTile(
                leading: const Icon(Icons.location_on, color: Colors.red),
                title: const Text('Last Known Location'),
                subtitle: Text(rider['location']!),
              ),
              ListTile(
                leading: const Icon(Icons.videocam, color: Color(0xFF1A5276)),
                title: const Text('Camera Status'),
                subtitle: Text(
                  rider['camera'] == 'Active'
                      ? 'Active & Monitoring'
                      : 'Camera Off',
                ),
              ),
              ListTile(
                leading: const Icon(Icons.warning, color: Colors.amber),
                title: const Text('Recent Hazards Reported'),
                subtitle: Text(rider['reports']!),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fleet Manager Portal',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1A5276),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AuthScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Analytics Cards Row
            Row(
              children: [
                _buildStatCard('Total Riders', '24', Icons.people, Colors.blue),
                const SizedBox(width: 8),
                _buildStatCard(
                  'Active Now',
                  '9',
                  Icons.directions_bike,
                  Colors.green,
                ),
                const SizedBox(width: 8),
                _buildStatCard(
                  'Hazards (Wk)',
                  '37',
                  Icons.warning,
                  Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 2. Fleet Overview Map Simulation
            const Text(
              'Live Fleet Map',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blueGrey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.map, size: 100, color: Colors.black12),
                  const Positioned(
                    top: 30,
                    left: 50,
                    child: Chip(
                      avatar: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 4,
                      ),
                      label: Text(
                        'Rahul (Riding)',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 30,
                    right: 60,
                    child: Chip(
                      avatar: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 4,
                      ),
                      label: Text(
                        'Priya (Riding)',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    right: 120,
                    child: Chip(
                      avatar: const CircleAvatar(
                        backgroundColor: Colors.orange,
                        radius: 4,
                      ),
                      label: Text(
                        'Aman (Idle)',
                        style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. Active Riders List
            const Text(
              'Fleet Riders List',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: fleetRiders.length,
              itemBuilder: (context, index) {
                final rider = fleetRiders[index];
                final isRiding = rider['status'] == 'Riding';

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    onTap: () => _showRiderDetails(rider),
                    leading: CircleAvatar(
                      backgroundColor: isRiding
                          ? Colors.green[100]
                          : Colors.grey[200],
                      child: Icon(
                        Icons.two_wheeler,
                        color: isRiding ? Colors.green[800] : Colors.grey[600],
                      ),
                    ),
                    title: Text(
                      rider['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Status: ${rider['status']} | Camera: ${rider['camera']}',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 6),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
