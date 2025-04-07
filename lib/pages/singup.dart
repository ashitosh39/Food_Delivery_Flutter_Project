import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/bottomnav.dart';
import 'package:food_delivery_app/pages/home.dart';
import 'package:food_delivery_app/pages/login.dart';
import 'package:food_delivery_app/service/database.dart';
import 'package:food_delivery_app/service/shared_pref.dart';
import 'package:food_delivery_app/service/widget_support.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();

  registration() async {
    if (password != null &&
        namecontroller.text != "" &&
        mailcontroller.text != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String Id = randomAlpha(10);
        String userId = userCredential.user!.uid;

        // Creating user details map
        Map<String, dynamic> userInfoMap = {
          "Name": namecontroller.text,
          "Email": mailcontroller.text,
          "Id": Id,
        };

        // Storing user data in Firestore

        await SharedpreferenceHelper().saveUserEmail(email);
        await SharedpreferenceHelper().saveUserName(namecontroller.text);
        await SharedpreferenceHelper().saveUserId(Id);
        await DatabaseMethods().addUserDetails(userInfoMap, Id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        );

        // Navigate to BottomNav after successful registration
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LogIn()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account already exists",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          );
          // } else {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(
          //       backgroundColor: Colors.redAccent,
          //       content: Text(
          //         "Error: ${e.message}",
          //         style: TextStyle(fontSize: 18.0),
          //   )));
          // }
        }
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.9,
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
                    height: 100,
                    fit: BoxFit.fill,
                    width: 180,
                  ),
                  Image.asset(
                    "images/logo.png",
                    width: 150,
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 4.9,
                left: 20.0,
                right: 20.0,
              ),
              child: Material(
                elevation: 3.0,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: EdgeInsets.only(right: 20.0, left: 20.0),
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
                          "SingUp",
                          style: AppWidget.HeadlineTextFieldStyle(),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      Text("Name", style: AppWidget.singUpTextFieldStyle()),
                      SizedBox(height: 5.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFececf8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Name",
                            prefixIcon: Icon(Icons.person_outlined),
                          ),
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
                      SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: () {
                          if (namecontroller.text != "" &&
                              mailcontroller.text != "" &&
                              passwordcontroller.text != "") {
                            setState(() {
                              name = namecontroller.text;
                              email = mailcontroller.text;
                              password = passwordcontroller.text;
                            });
                            registration();
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
                                "Sing Up",
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
                            "Already have an account?",
                            style: AppWidget.simpleTextFieldStyle(),
                          ),
                          SizedBox(width: 10.0),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LogIn(),
                                ),
                              );
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LogIn(),
                                  ),
                                );
                              },
                              child: Text(
                                "LogIn",
                                style: AppWidget.boldTextFieldStyle().copyWith(
                                  color: Colors.red,
                                ),
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

// Widget _buildTextField(
//   TextEditingController controller,
//   String hint,
//   IconData icon, {
//   bool isPassword = false,
// }) {
//   return Container(
//     decoration: BoxDecoration(
//       color: Color(0xFFececf8),
//       borderRadius: BorderRadius.circular(10),
//     ),
//     child: TextField(
//       controller: controller,
//       obscureText: isPassword,
//       decoration: InputDecoration(
//         border: InputBorder.none,
//         hintText: hint,
//         prefixIcon: Icon(icon),
//       ),
//     ),
//   );
// }

// Widget _buildSignUpButton() {
//   return Center(
//     child: Container(
//       width: 200,
//       height: 60,
//       decoration: BoxDecoration(
//         color: Color(0xffef2b39),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: Center(
//         child: Text("Sign Up", style: AppWidget.boldwhitwTextFieldStyle()),
//       ),
//     ),
//   );
// }

// void showAlertDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Missing Information"),
  //         content: Text("Please enter your Name, Email, and Password."),
  //         actions: [
  //           TextButton(
  //             child: Text("OK"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Container(
  //       child: Stack(
  //         children: [
  //           Container(
  //             height: MediaQuery.of(context).size.height / 2.5,
  //             padding: EdgeInsets.only(top: 40.0),
  //             width: MediaQuery.of(context).size.width,
  //             decoration: BoxDecoration(
  //               color: Color(0xffffefbf),
  //               borderRadius: BorderRadius.only(
  //                 bottomLeft: Radius.circular(40),
  //                 bottomRight: Radius.circular(40),
  //               ),
  //             ),
  //             child: Column(
  //               children: [
  //                 Image.asset(
  //                   "images/pan.png",
  //                   height: 150,
  //                   fit: BoxFit.fill,
  //                   width: 240,
  //                 ),
  //                 Image.asset(
  //                   "images/logo.png",
  //                   width: 150,
  //                   height: 50,
  //                   fit: BoxFit.cover,
  //                 ),
  //               ],
  //             ),
  //           ),
  //           Container(
  //             margin: EdgeInsets.only(
  //               top: MediaQuery.of(context).size.height / 4.2,
  //               left: 20.0,
  //               right: 20.0,
  //             ),
  //             child: Material(
  //               elevation: 3.0,
  //               borderRadius: BorderRadius.circular(20),
  //               child: Container(
  //                 padding: EdgeInsets.only(right: 20.0, left: 20.0),
  //                 width: MediaQuery.of(context).size.width,
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(20),
  //                 ),
  //                 height: MediaQuery.of(context).size.height / 1.8,
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     SizedBox(height: 20.0),
  //                     Center(
  //                       child: Text(
  //                         "SingUp",
  //                         style: AppWidget.HeadlineTextFieldStyle(),
  //                       ),
  //                     ),
  //                     SizedBox(height: 15.0),
  //                     Text("Name", style: AppWidget.singUpTextFieldStyle()),
  //                     SizedBox(height: 5.0),
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         color: Color(0xFFececf8),
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       child: TextField(
  //                         decoration: InputDecoration(
  //                           border: InputBorder.none,
  //                           hintText: "Enter Name",
  //                           prefixIcon: Icon(Icons.person_2_outlined),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(height: 20.0),
  //                     Text("Email", style: AppWidget.singUpTextFieldStyle()),
  //                     SizedBox(height: 5.0),
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         color: Color(0xFFececf8),
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       child: TextField(
                         
  //                         decoration: InputDecoration(
  //                           border: InputBorder.none,
  //                           hintText: "Enter Email",
  //                           prefixIcon: Icon(Icons.mail_outline),
  //                         ),
  //                       ),
  //                     ),

  //                     SizedBox(height: 20.0),
  //                     Text("Password", style: AppWidget.singUpTextFieldStyle()),
  //                     SizedBox(height: 5.0),
  //                     Container(
  //                       decoration: BoxDecoration(
  //                         color: Color(0xFFececf8),
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       child: TextField(
                         
                       
  //                         decoration: InputDecoration(
  //                           border: InputBorder.none,
  //                           hintText: "Enter Password",
  //                           prefixIcon: Icon(Icons.password_outlined),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(height: 30.0),
  //                     Center(
  //                       child: Container(
  //                         width: 200,
  //                         height: 60,
  //                         decoration: BoxDecoration(
  //                           color: Color(0xffef2b39),
  //                           borderRadius: BorderRadius.circular(30),
  //                         ),
  //                         child: Center(
  //                           child: GestureDetector(
  //                             onTap: () {
  //                               Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                   builder: (context) => Home(),
  //                                 ),
  //                               );
  //                             },
  //                             child: Text(
  //                               "Sing Up",
  //                               style: AppWidget.boldwhitwTextFieldStyle(),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(height: 30.0),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Text(
  //                           "Already have an account?",
  //                           style: AppWidget.simpleTextFieldStyle(),
  //                         ),
  //                         SizedBox(width: 10.0),
  //                         GestureDetector(
  //                           onTap: () {
  //                             Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                 builder: (context) => LogIn(),
  //                               ),
  //                             );
  //                           },
  //                           child: GestureDetector(
  //                             onTap: () {
  //                               Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                   builder: (context) => LogIn(),
  //                                 ),
  //                               );
  //                             },
  //                             child: Text(
  //                               "LogIn",
  //                               style: AppWidget.boldTextFieldStyle(),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }



// regidtration() async {
  //   email = mailcontroller.text;
  //   password = passwordcontroller.text;
  //   name = namecontroller.text;

  //   if (email.isNotEmpty && password.isNotEmpty && name.isNotEmpty) {
  //     try {
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(email: email, password: password);
  //       String Id = randomAlphaNumeric(10);

  //       Map<String, dynamic> userInfoMap = {
  //         "Name": name,
  //         "Email": email,
  //         "Id": Id,
  //       };

  //       // Ensure that SharedpreferenceHelper is imported correctly and instantiated
  //       SharedpreferenceHelper sharedpreferenceHelper =
  //           SharedpreferenceHelper();

  //       await sharedpreferenceHelper.saveUserEmail(email);
  //       await sharedpreferenceHelper.saveUserName(name);
  //       await DatabaseMethods().addUserDetails(userInfoMap, Id);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           backgroundColor: Colors.green,
  //           content: Text(
  //             "Register Successfully",
  //             style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
  //           ),
  //         ),
  //       );
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => BottomNav()),
  //       );
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'weak-password') {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             backgroundColor: Colors.orangeAccent,
  //             content: Text(
  //               "Password provided is too weak",
  //               style: TextStyle(fontSize: 18.0),
  //             ),
  //           ),
  //         );
  //       } else if (e.code == "email-already-in-use") {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             backgroundColor: Colors.orangeAccent,
  //             content: Text(
  //               "Account already exists",
  //               style: TextStyle(fontSize: 18.0),
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   }
  // }