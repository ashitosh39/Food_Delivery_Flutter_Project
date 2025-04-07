import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/model/burger_model.dart';
import 'package:food_delivery_app/model/category_model.dart';
import 'package:food_delivery_app/model/chinese_model.dart';
import 'package:food_delivery_app/model/maxican_model.dart';
import 'package:food_delivery_app/model/pizza_model.dart';
import 'package:food_delivery_app/pages/detail_page.dart';
import 'package:food_delivery_app/service/burger_data.dart';
import 'package:food_delivery_app/service/category_data.dart';
import 'package:food_delivery_app/service/chinese_data.dart';
import 'package:food_delivery_app/service/database.dart';
import 'package:food_delivery_app/service/maxican_data.dart';
import 'package:food_delivery_app/service/pizza_data.dart';
import 'package:food_delivery_app/service/widget_support.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  List<CategoryModel> categories = [];
  List<Pizzamodel> pizza = [];
  List<BurgerModel> burger = [];
  List<ChineseModel> chinese = [];
  List<MaxicanModel> maxican = [];
  bool search = false;
  String track = "0";
  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    categories = getCategories();
    pizza = getPizza();
    burger = getBurger();
    chinese = getChinese();
    maxican = getMaxican();
    super.initState();
  }


  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });

    }
    setState(() {
      search = true;
    });

    var CapitalizedValue = value.substring(0, 1).toUpperCase() + value.substring(1);
    if(queryResultSet.isEmpty && value.length == 1) {
      DatabaseMethods().search(value).then((QuerySnapshot docs){
        for (int i = 0; i< docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());

        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element){
        if (element["Name"].startWith(CapitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });

      
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 20.0, top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "images/logo.png",
                      height: 50,
                      width: 110,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      "Order your favourite food",
                      style: AppWidget.simpleTextFieldStyle(),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "images/boy2.jpg",
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0),
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFececf8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: searchcontroller,
                      onChanged: (value) {
                        initiateSearch(value.toUpperCase());
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search Food Item...",
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xffef2b39),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.search, color: Colors.white, size: 30.0),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryTile(
                    categories[index].name!,
                    categories[index].image!,
                    index.toString(),
                  );
                },
              ),
            ),
            SizedBox(height: 20.0),
            track == "0"
                ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 5.0, bottom: 20.0),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 3.0,
                      ),
                      itemCount: pizza.length,
                      itemBuilder: (context, index) {
                        return FoodTitle(
                          pizza[index].name!,
                          pizza[index].image!,
                          pizza[index].price!,
                        );
                      },
                    ),
                  ),
                )
                : track == "1"
                ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 5.0, bottom: 20.0),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 3.0,
                      ),
                      itemCount: burger.length,
                      itemBuilder: (context, index) {
                        return FoodTitle(
                          burger[index].name!,
                          burger[index].image!,
                          burger[index].price!,
                        );
                      },
                    ),
                  ),
                )
                : track == "2"
                ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 5.0, bottom: 20.0),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 3.0,
                      ),
                      itemCount: chinese.length,
                      itemBuilder: (context, index) {
                        return FoodTitle(
                          chinese[index].name!,
                          chinese[index].image!,
                          chinese[index].price!,
                        );
                      },
                    ),
                  ),
                )
                : track == "3"
                ? Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 5.0, bottom: 20.0),
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 3.0,
                      ),
                      itemCount: maxican.length,
                      itemBuilder: (context, index) {
                        return FoodTitle(
                          maxican[index].name!,
                          maxican[index].image!,
                          maxican[index].price!,
                        );
                      },
                    ),
                  ),
                )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget FoodTitle(String name, String image, String price) {
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      padding: EdgeInsets.only(left: 10.0, top: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              image,
              height: 150,
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
          Text(name, style: AppWidget.boldTextFieldStyle()),
          Text("\₹" + price, style: AppWidget.priceTextFieldStyle()),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => DetailPage(
                            image: image,
                            name: name,
                            price: price,
                          ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 239, 43, 79),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

 
  Widget CategoryTile(String name, String image, String categoryindex) {
    return GestureDetector(
      onTap: () {
        track = categoryindex.toString();
        setState(() {});
      },
      child:
          track == categoryindex
              ? Container(
                margin: EdgeInsets.only(right: 20.0, bottom: 10.0),
                child: Material(
                  elevation: 3.0,
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),

                    decoration: BoxDecoration(
                      color: Color(0xffef2b39),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          image,
                          height: 40,
                          width: 40,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10.0),
                        Text(name, style: AppWidget.whitwTextFieldStyle()),
                      ],
                    ),
                  ),
                ),
              )
              : Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                margin: EdgeInsets.only(right: 20.0, bottom: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      image,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10.0),
                    Text(name, style: AppWidget.simpleTextFieldStyle()),
                  ],
                ),
              ),
    );
  }
   // Widget BurgerFoodTitle(String name, String image, String price) {
  //   return Container(
  //     decoration: BoxDecoration(),
  //     child: Column(
  //       children: [
  //         Center(
  //           child: Image.asset(
  //             image,
  //             height: 150,
  //             width: 150,
  //             fit: BoxFit.contain,
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             Container(
  //               height: 50,
  //               width: 80,
  //               decoration: BoxDecoration(
  //                 color: Color.fromARGB(255, 239, 43, 79),
  //                 borderRadius: BorderRadius.only(
  //                   topLeft: Radius.circular(30),
  //                   bottomRight: Radius.circular(30),
  //                 ),
  //               ),
  //               child: Icon(
  //                 Icons.arrow_forward,
  //                 color: Colors.white,
  //                 size: 30.0,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

}
