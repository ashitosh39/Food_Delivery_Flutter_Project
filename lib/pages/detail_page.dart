// import 'dart:io';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_delivery_app/service/constant.dart';
import 'package:food_delivery_app/service/database.dart';
import 'package:food_delivery_app/service/shared_pref.dart';
import 'package:food_delivery_app/service/widget_support.dart';
import 'package:http/http.dart' as http;
import 'package:random_string/random_string.dart';

class DetailPage extends StatefulWidget {
  String image;
  String name;
  String price;
  DetailPage({required this.image, required this.name, required this.price});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Map<String, dynamic>? paymentIntent;
  String? name, id, email;
  int quantity = 1, totalprice = 0;

  getthesharedpref() async {
    name = await SharedpreferenceHelper().getUserName();
    id = await SharedpreferenceHelper().getUserId();
    email = await SharedpreferenceHelper().getUserEmail();
    print(name);
    print(id);
    print(email);
    setState(() {});
  }

  @override
  void initState() {
    totalprice = int.parse(widget.price);
    getthesharedpref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xffef2b39),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Icon(Icons.arrow_back, size: 30.0, color: Colors.white),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: Image.asset(
                widget.image,
                height: MediaQuery.of(context).size.height / 3,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20.0),
            Text(widget.name, style: AppWidget.HeadlineTextFieldStyle()),
            Text("\₹" + widget.price, style: AppWidget.priceTextFieldStyle()),
            SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                "We,ve established that most chesse will melt when baked atop pizza. But which will not only melt but stretch into those  gooye, messy standard that can make pizza eating such a delightfully challenging endeavor?",
                style: AppWidget.simpleTextFieldStyle(),
              ),
            ),
            SizedBox(height: 30.0),
            Text("Quantity", style: AppWidget.simpleTextFieldStyle()),
            SizedBox(height: 10.0),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (quantity > 1) {
                      quantity = quantity - 1;
                      totalprice = totalprice - int.parse(widget.price);
                      setState(() {});
                    } else {
                      // Show alert message when quantity is less than or equal to 1
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(
                            child: AlertDialog(
                              title: Text(
                                "Minimum Quantity Alert",
                                style: AppWidget.boldTextFieldStyle(),
                              ),
                              content: Text(
                                "At least one quantity is required.",
                                style: AppWidget.simpleTextFieldStyle(),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text(
                                    "OK",
                                    style: AppWidget.HeadlineTextFieldStyle(),
                                  ),
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                    ).pop(); // Close the dialog
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                Text(
                  quantity.toString(),
                  style: AppWidget.HeadlineTextFieldStyle(),
                ),
                SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () {
                    quantity = quantity + 1;
                    totalprice = totalprice + int.parse(widget.price);
                    setState(() {});
                  },
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Color(0xffef2b39),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 30.0),
                    ),
                  ),
                ),
                SizedBox(width: 30.0),
              ],
            ),

            SizedBox(height: 20.0),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  // elevation: 3.0,
                  // borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 70,
                    // width: 170,
                    // decoration: BoxDecoration(
                    //   color: Color.fromARGB(255, 231, 193, 4),
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        // child: Center(
                        child: Text(
                          "\₹" + totalprice.toString(),
                          style: AppWidget.priceboldwhitwTextFieldStyle(),
                          // ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 40.0),

                GestureDetector(
                  onTap: () {
                    makePayment(totalprice.toString());
                  },
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                      height: 70,
                      width: 420,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 170, 4),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Text(
                          "BUY NOW",
                          style: AppWidget.orderboldwhitwTextFieldStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent?['client_secrete'],
              merchantDisplayName: 'Ashu',
            ),
          )
          .then((value) {});

      displayPaymentSheet(amount);
    } catch (e, s) {
      print('exeption:$e$s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) async {
            String orderId = randomAlphaNumeric(10);
            Map<String, dynamic> userOrderMap = {
              "Name": name,
              "id": id,
              "Quantity": quantity.toString(),
              "Total": totalprice.toString(),
              "Email": email,
              "FoodName": widget.name,
              "FoodImage": widget.image,
              "OrderId": orderId,
              "Status": "Pending",
            };
            await DatabaseMethods().addUserOrderDetails(
              userOrderMap,
              id!,
              orderId,
            );
            await DatabaseMethods().addAdminOrderDetails(userOrderMap, orderId);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  "Order Palced Successfully!",
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            );
            //ignore: use_build_context_synchronously
            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            Text("Payment Successfull"),
                          ],
                        ),
                      ],
                    ),
                  ),
            );
            paymentIntent = null;
          })
          .onError((error, StackTrace) {
            print("Error is: ----> $error $StackTrace");
          });
    } on StripeException catch (e) {
      print("Error is:---> $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(content: Text("Cancelled")),
      );
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secratKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('err cahrging user: ${err.toString()}');
      throw err;
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount)) * 100;
    return calculatedAmount.toString();
  }
}
