import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:food_delivery_app/service/widget_support.dart";

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Stream? orderStream;

  Widget allOrders() {
    return StreamBuilder(
      stream: orderStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  margin: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 5.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: Color(0xffef2b39),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "Near Market",
                                style: AppWidget.simpleTextFieldStyle(),
                              ),
                            ],
                          ),
                          Divider(),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "images/burger1.png",
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 20.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Cheese Burger",
                                    style: AppWidget.boldTextFieldStyle(),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.format_list_numbered,
                                        color: Color(0xffef2b39),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "4",
                                        style: AppWidget.boldTextFieldStyle(),
                                      ),
                                      SizedBox(width: 30.0),
                                      Icon(
                                        Icons.monetization_on,
                                        color: Color(0xffef2b39),
                                      ),
                                      SizedBox(width: 10.0),
                                      Text(
                                        "\₹20",
                                        style: AppWidget.boldTextFieldStyle(),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    "Pending!",
                                    style: TextStyle(
                                      color: Color(0xffef2b39),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sample data (You can replace it with actual data from your backend or provider)
    List<Map<String, String>> orders = [
      {
        "name": "Cheese Burger",
        "quantity": "4",
        "price": "₹20",
        "status": "Pending!",
        "image": "images/burger1.png",
      },
      {
        "name": "Normal Burger",
        "quantity": "6",
        "price": "₹40",
        "status": "Pending!",
        "image": "images/burger2.png",
      },
      {
        "name": "Cheese Maxican",
        "quantity": "2",
        "price": "₹100",
        "status": "Pending!",
        "image": "images/Maxican1.png",
      },
      {
        "name": "Chinese",
        "quantity": "8",
        "price": "₹60",
        "status": "Pending!",
        "image": "images/Chinese1.png",
      },
      {
        "name": "Chiken Lolipop",
        "quantity": "10",
        "price": "₹80",
        "status": "Pending!",
        "image": "images/chinese3.png",
      },
      {
        "name": "Maxican",
        "quantity": "2",
        "price": "₹200",
        "status": "Pending!",
        "image": "images/Maxican6.png",
      },
    ];

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Orders", style: AppWidget.HeadlineTextFieldStyle()),
              ],
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 226, 226, 246),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    var order = orders[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 20.0,
                      ),
                      child: Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xffef2b39),
                                  ),
                                  SizedBox(width: 10.0),
                                  Text(
                                    "Near Market",
                                    style: AppWidget.simpleTextFieldStyle(),
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                children: [
                                  Image.asset(
                                    order["image"]!,
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 20.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        order["name"]!,
                                        style: AppWidget.boldTextFieldStyle(),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.format_list_numbered,
                                            color: Color(0xffef2b39),
                                          ),
                                          SizedBox(width: 10.0),
                                          Text(
                                            order["quantity"]!,
                                            style:
                                                AppWidget.boldTextFieldStyle(),
                                          ),
                                          SizedBox(width: 30.0),
                                          Icon(
                                            Icons.monetization_on,
                                            color: Color(0xffef2b39),
                                          ),
                                          SizedBox(width: 10.0),
                                          Text(
                                            order["price"]!,
                                            style:
                                                AppWidget.boldTextFieldStyle(),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        order["status"]!,
                                        style: TextStyle(
                                          color: Color(0xffef2b39),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              // Divider(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



















// import 'package:flutter/material.dart';

// class Order extends StatefulWidget {
//   const Order({super.key});

//   @override
//   State<Order> creatState() => _OrderState();
// }

// class _OrderState extends State<order> {
//   @override
//   Widget Build(BuildContext context) {
//     return Scaffold(body: Container(child: Column(children: [

//         ], ),  )
        
//         );
//   }
// }
