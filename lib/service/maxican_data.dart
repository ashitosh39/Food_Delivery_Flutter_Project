import 'package:food_delivery_app/model/burger_model.dart';
import 'package:food_delivery_app/model/chinese_model.dart';
import 'package:food_delivery_app/model/maxican_model.dart';

List<MaxicanModel> getMaxican() {
  List<MaxicanModel> maxican = [];
  MaxicanModel maxicanModel = new MaxicanModel();

  maxicanModel.name = "Chiken Combination";
  maxicanModel.image = "images/Maxican1.png";
  maxicanModel.price = "50";
  maxican.add(maxicanModel);
  maxicanModel = new MaxicanModel();

  maxicanModel.name = "Anda Noodles";
  maxicanModel.image = "images/Maxican3.png";
  maxicanModel.price = "150";
  maxican.add(maxicanModel);
  maxicanModel = new MaxicanModel();
();

  maxicanModel.name = "Chiken Lolipop";
  maxicanModel.image = "images/Maxican3.png";
  maxicanModel.price = "90";
  maxican.add(maxicanModel);
  maxicanModel = new MaxicanModel();
();

  maxicanModel.name = "Chiken Chilli";
  maxicanModel.image = "images/Maxican4.png";
  maxicanModel.price = "80";
  maxican.add(maxicanModel);
  maxicanModel = new MaxicanModel();
();

  maxicanModel.name = " Hot and Sour soop";
  maxicanModel.image = "images/Maxican5.png";
  maxicanModel.price = "120";
  maxican.add(maxicanModel);
  maxicanModel = new MaxicanModel();

  maxicanModel.name = "Hot and Sour soop";
  maxicanModel.image = "images/Maxican4.png";
  maxicanModel.price = "120";
  maxican.add(maxicanModel);
  maxicanModel = new MaxicanModel();
  return maxican;
}
