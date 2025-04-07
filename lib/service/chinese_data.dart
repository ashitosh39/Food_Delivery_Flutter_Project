import 'package:food_delivery_app/model/burger_model.dart';
import 'package:food_delivery_app/model/chinese_model.dart';

List<ChineseModel> getChinese() {
  List<ChineseModel> chinese = [];
  ChineseModel chineseModel = new ChineseModel();

  chineseModel.name = "Chiken Combination";
  chineseModel.image = "images/Chinese1.png";
  chineseModel.price = "50";
  chinese.add(chineseModel);
  chineseModel = new ChineseModel();

  chineseModel.name = "Anda Noodles";
  chineseModel.image = "images/chinese2.png";
  chineseModel.price = "150";
  chinese.add(chineseModel);
  chineseModel = new ChineseModel();
();

  chineseModel.name = "Chiken Lolipop";
  chineseModel.image = "images/chinese3.png";
  chineseModel.price = "90";
  chinese.add(chineseModel);
  chineseModel = new ChineseModel();
();

  chineseModel.name = "Chiken Chilli";
  chineseModel.image = "images/chinese4.png";
  chineseModel.price = "80";
  chinese.add(chineseModel);
  chineseModel = new ChineseModel();
();

  chineseModel.name = " Hot and Sour soop";
  chineseModel.image = "images/chinese6.png";
  chineseModel.price = "120";
  chinese.add(chineseModel);
  chineseModel = new ChineseModel();

  chineseModel.name = "Hot and Sour soop";
  chineseModel.image = "images/chinese6.png";
  chineseModel.price = "120";
  chinese.add(chineseModel);
  chineseModel = new ChineseModel();
  return chinese;
}
