import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/bottomnav.dart';
import 'package:food_delivery_app/pages/onboarding.dart';
import 'package:food_delivery_app/pages/order.dart';
import 'package:food_delivery_app/service/widget_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const String KEYLOGIN = "isLoggedIn";
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<Offset>(
      begin: Offset(-1.5, 0.0), // Start from left outside the screen
      end: Offset(0.0, 0.0), // Slide to its normal position
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start the animation after 1 second
    Timer(Duration(milliseconds : 1000), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool(KEYLOGIN) ?? false;

    // Navigate after a delay
    Timer(Duration(seconds: 2), () {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNav()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Onbording()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/onboard.png"),
            SizedBox(height: 20.0),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return SlideTransition(
                  position: _animation,
                  child: Text(
                    "The Fastest Food Delivery App",
                    textAlign: TextAlign.center,
                    style: AppWidget.HeadlineTextFieldStyle(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
