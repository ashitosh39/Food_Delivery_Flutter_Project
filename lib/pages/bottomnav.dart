import "package:flutter/material.dart";
import "package:curved_navigation_bar/curved_navigation_bar.dart";
import "package:food_delivery_app/pages/home.dart";
import "package:food_delivery_app/pages/order.dart";
import "package:food_delivery_app/pages/profile.dart";
import "package:food_delivery_app/pages/wallet.dart";

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages;

  late Home homepage;
  late Order order;
  late Wallet wallet;
  late ProfilePage profile;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    homepage = Home();
    order = Order();
    wallet = Wallet();
    profile = ProfilePage();

    pages = [homepage, order, wallet, profile];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentTabIndex],
      bottomNavigationBar: CurvedNavigationBar(
        height: 70,
        backgroundColor: const Color.fromARGB(255, 253, 250, 250),
        color: Colors.black,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home,
            color: Colors.white,
            size: 30.0,
          ),
          Icon(
            Icons.shopping_bag,
            color: Colors.white,
            size: 30.0,
          ),
          Icon(
            Icons.wallet,
            color: Colors.white,
            size: 30.0,
          ),
          Icon(
            Icons.person,
            color: Colors.white,
            size: 30.0,
          ),
        ],
      ),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:food_delivery_app/pages/home.dart';
// import 'package:food_delivery_app/pages/order.dart';
// import 'package:food_delivery_app/pages/profile.dart';
// import 'package:food_delivery_app/pages/wallet.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Food Delivery App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const BottomNav(), // BottomNav as the home page
//     );
//   }
// }

// class BottomNav extends StatefulWidget {
//   const BottomNav({super.key});

//   @override
//   State<BottomNav> createState() => _BottomNavState();
// }

// class _BottomNavState extends State<BottomNav> {
//   late List<Widget> pages;

//   late Home homepage;
//   late Order order;
//   late Wallet wallet;
//   late ProfilePage profile;

//   int currentTabIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     homepage = Home();
//     order = Order();
//     wallet = Wallet();
//     profile = ProfilePage();

//     pages = [homepage, order, wallet, profile];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[currentTabIndex],
//       bottomNavigationBar: CurvedNavigationBar(
//         height: 70,
//         backgroundColor: Colors.white,
//         color: Colors.black,
//         animationDuration: Duration(milliseconds: 500),
//         onTap: (int index) {
//           setState(() {
//             currentTabIndex = index;
//           });
//         },
//         items: [
//           Icon(
//             Icons.home,
//             color: Colors.white,
//             size: 30.0,
//           ),
//           Icon(
//             Icons.shopping_bag,
//             color: Colors.white,
//             size: 30.0,
//           ),
//           Icon(
//             Icons.wallet,
//             color: Colors.white,
//             size: 30.0,
//           ),
//           Icon(
//             Icons.person,
//             color: Colors.white,
//             size: 30.0,
//           ),
//         ],
//       ),
//     );
//   }
// }
