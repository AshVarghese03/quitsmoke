import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:madnew/screens/login_screen.dart'; // Import your login screen
import 'package:madnew/screens/guide_screen.dart'; // Import the guide screen

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Home Screen!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your logic here
              },
              child: Text('Button'),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  int _smokeFreeHours = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadSmokeFreeHours();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(hours: 1), (timer) {
      setState(() {
        _smokeFreeHours++;
        _saveSmokeFreeHours();
      });
    });
  }

  void _resetTimer() {
    setState(() {
      _smokeFreeHours = 0;
      _saveSmokeFreeHours();
    });
  }

  void _loadSmokeFreeHours() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _smokeFreeHours = prefs.getInt('smokeFreeHours') ?? 0;
    });
  }

  void _saveSmokeFreeHours() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('smokeFreeHours', _smokeFreeHours);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()), // Navigate to your login page
    );
  }

  void _navigateToGuidePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GuideScreen()), // Navigate to the guide screen
    );
  }

  @override
  Widget build(BuildContext context) {
    Color accentColor = Theme.of(context).colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quit Smoke',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your existing code for the dashboard container
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: accentColor,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
