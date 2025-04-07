import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/bottomnav.dart';
import 'package:food_delivery_app/pages/singup.dart';
import 'package:food_delivery_app/pages/spalsh_screen.dart';
import 'package:food_delivery_app/service/widget_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  static const String KEYLOGIN = "isLoggedIn";
  String email = "", password = "";
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  userLogin() async {
    String email = mailcontroller.text.trim();
    String password = passwordcontroller.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
        // Save login state
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(KEYLOGIN, true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNav()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "An error occurred";
      if (e.code == 'user-not-found') {
        message = "No user found for that email";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password provided";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: message,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ), // White color
                ),
              ],
            ),
          ),
          backgroundColor: Colors.black, // Optional: Makes text more readable
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.5,
              padding: EdgeInsets.only(top: 40.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Color(0xffffefbf),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Image.asset(
                    "images/pan.png",
                    height: 150,
                    fit: BoxFit.fill,
                    width: 240,
                  ),
                  Image.asset(
                    "images/logo.png",
                    width: 150,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 4.2,
                left: 20.0,
                right: 20.0,
              ),
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.0),
                      Center(
                        child: Text(
                          "Log In",
                          style: AppWidget.HeadlineTextFieldStyle(),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text("Email", style: AppWidget.singUpTextFieldStyle()),
                      SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: mailcontroller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Email",
                            prefixIcon: Icon(Icons.mail_outline),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text("Password", style: AppWidget.singUpTextFieldStyle()),
                      SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          // obscureText: true,
                          controller: passwordcontroller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Password",
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Forgot Password?",
                            style: AppWidget.simpleTextFieldStyle(),
                          ),
                        ],
                      ),
                      SizedBox(height: 50.0),
                      GestureDetector(
                        onTap: () {
                          if (mailcontroller.text.isNotEmpty &&
                              passwordcontroller.text.isNotEmpty) {
                            setState(() {
                              email = mailcontroller.text;
                              password = passwordcontroller.text;
                            });
                            userLogin();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please enter email and password",
                                ),
                              ),
                            );
                          }
                        },
                        child: Center(
                          child: Container(
                            width: 200,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color(0xffef2b39),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Log In",
                                style: AppWidget.boldwhitwTextFieldStyle(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: AppWidget.simpleTextFieldStyle(),
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              var sharedpref = SharedPreferences.getInstance();
                              // sharedpref.setBool(SplashScreen.KEYLOGIN, true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign Up",
                              style: AppWidget.boldTextFieldStyle().copyWith(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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















// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:food_delivery_app/pages/bottomnav.dart';
// import 'package:food_delivery_app/pages/singup.dart';
// import 'package:food_delivery_app/service/database.dart';
// import 'package:food_delivery_app/service/widget_support.dart';

// class LogIn extends StatefulWidget {
//   const LogIn({super.key});

//   @override
//   State<LogIn> createState() => _LogInState();
// }

// class _LogInState extends State<LogIn> {
//   String email = "", password = "";
//   TextEditingController mailcontroller = TextEditingController();
//   TextEditingController passwordcontroller = TextEditingController();
  

//   userLogin() async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => BottomNav()),
//       );
//     } on FirebaseAuthException catch (e) {
//       String message = "An error Occurred";
//       if (e.code == 'user_not-found') {
//         message = "No user found for that email";
//       }  else if (e.code == 'wrong-password') {
//         message = "Wrong password provided";
//       }
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(
//               message,
//               style: TextStyle(fontSize: 18.0, color: Colors.black),
//             ),
//           ),
//         );
//     }
//   }

  

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       body: Container(
//         child: Stack(
//           children: [
//             Container(
//               height: MediaQuery.of(context).size.height / 2.5,
//               padding: EdgeInsets.only(top: 40.0),
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 color: Color(0xffffefbf),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(40),
//                   bottomRight: Radius.circular(40),
//                 ),
//               ),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     "images/pan.png",
//                     height: 150,
//                     fit: BoxFit.fill,
//                     width: 240,
//                   ),
//                   Image.asset(
//                     "images/logo.png",
//                     width: 150,
//                     height: 50,
//                     fit: BoxFit.cover
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height / 4.2,
//                 left: 20.0,
//                 right: 20.0,
//               ),
//               child: Material(
//                 elevation: 3.0,
//                 borderRadius: BorderRadius.circular(20),
//                 child: Container(
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   width: MediaQuery.of(context).size.width,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   height: MediaQuery.of(context).size.height / 1.8,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 20.0),
//                       Center(
//                         child: Text(
//                           "LogIn",
//                           style: AppWidget.HeadlineTextFieldStyle())),
//                       SizedBox(height: 20.0),

//                       // SizedBox(height: 20.0),
//                       Text("Email", style: AppWidget.singUpTextFieldStyle()),
//                       SizedBox(height: 5.0),
//                       // Container(
//                         // decoration: BoxDecoration(
//                         //   color: Color(0xFFececf8),
//                         //   borderRadius: BorderRadius.circular(10),
//                         // ),
//                         // child:
//                         TextField(
//                           controller: mailcontroller,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Enter Email",
//                             prefixIcon: Icon(Icons.mail_outline),
//                           ),
//                         ),
//                       // ),

//                       SizedBox(height: 20.0),
//                       Text("Password", style: AppWidget.singUpTextFieldStyle()),
//                       SizedBox(height: 5.0),
//                       // Container(
//                       //   decoration: BoxDecoration(
//                       //     color: Color(0xFFececf8),
//                       //     borderRadius: BorderRadius.circular(10),
//                       //   ),
//                         // child:
//                         TextField(
//                           // obscureText: true,
//                           controller: passwordcontroller,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,
//                             hintText: "Enter Password",
//                             prefixIcon: Icon(Icons.password_outlined),
//                           ),
//                         ),
//                       // ),

//                       SizedBox(height: 10.0),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,

//                         children: [
//                           Text(
//                             "Forgot Password?",
//                             style: AppWidget.simpleTextFieldStyle(),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 50.0),
//                       GestureDetector(
//                         onTap: () {
//                           if (mailcontroller.text.isEmpty &&
//                               passwordcontroller.text.isEmpty) {
//                             setState(() {
//                               email = mailcontroller.text;
//                               password = passwordcontroller.text;
//                             });
//                             userLogin();
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter email and password"),
//                                 ),
//                                 );
//                               }
//                         },
//                         child: Center(
//                           child: Container(
//                             width: 200,
//                             height: 60,
//                             decoration: BoxDecoration(
//                               color: Color(0xffef2b39),
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: Center(
//                                 child: Text(
//                                   "Log In",
//                                   style: AppWidget.boldwhitwTextFieldStyle(),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
                      
//                       SizedBox(height: 30.0),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text(
//                             "Don't have account?",
//                             style: AppWidget.simpleTextFieldStyle(),
//                           ),
//                           SizedBox(width: 10.0),
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => SignUp(),
//                                 ),
//                               );
//                             },
//                             child: Text(
//                               "SingUp",
//                               style: AppWidget.boldTextFieldStyle().copyWith(
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
