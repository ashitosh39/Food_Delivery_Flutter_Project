import "package:flutter/material.dart";
import 'package:food_delivery_app/service/widget_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_delivery_app/pages/login.dart';
import 'package:flutter/services.dart'; // For closing the app

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  // Log out function to clear login state and navigate to the Login screen
  void _logout() async {
    // Get SharedPreferences instance
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Set the login state to false
    await prefs.setBool("isLoggedIn", false);

    // Optional: Log out the user from Firebase (if using Firebase Auth)
    // FirebaseAuth.instance.signOut(); // Uncomment if needed

    // Close the app after logging out
    SystemNavigator.pop(); // This will close the app
    
    // Navigate to the login screen (this will not execute after app closes)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LogIn()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Profile Page', style: AppWidget.boldTextFieldStyle())),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout, // Log out when button is pressed
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Customize the button color
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: Text("Log Out", style: AppWidget.boldwhitwTextFieldStyle(),),
            ),
          ],
        ),
      ),
    );
  }
}


