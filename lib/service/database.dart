import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }
   Future addUserOrderDetails(Map<String, dynamic> userOrderMap, String id, String orderid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Orders")
        .doc(orderid)
        .set(userOrderMap);
  }
     Future addAdminOrderDetails(Map<String, dynamic> userOrderMap, String orderid) async {
    return await FirebaseFirestore.instance
     
        .collection("Orders")
        .doc(orderid)
        .set(userOrderMap);
  }

  Future<QuerySnapshot> search(String updatedname) async {
    return await FirebaseFirestore.instance
        .collection("Food")
        .where(
          "SearchKey",
          isEqualTo: updatedname.substring(0, 1).toUpperCase(),
        )
        .get();
  }
}
