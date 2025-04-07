import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/login.dart';
import 'package:food_delivery_app/pages/singup.dart';
import 'package:food_delivery_app/service/widget_support.dart';

class Onbording extends StatefulWidget {
  const Onbording({super.key});

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Image.asset("images/onboard.png"),
            SizedBox(height: 20.0),
            Text(
              "The Fastest\nFood Delivery",
              textAlign: TextAlign.center,
              style: AppWidget.HeadlineTextFieldStyle(),
            ),
            SizedBox(height: 30.0),
            Text(
              "Craving somthing delicious?\n Order now and get your favorites\ndelivered fast!",

              textAlign: TextAlign.center,
              style: AppWidget.simpleTextFieldStyle(),
            ),
            SizedBox(height: 30.0),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Color(0xff8c592a),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                  child: Text(
                    "Get Started",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
