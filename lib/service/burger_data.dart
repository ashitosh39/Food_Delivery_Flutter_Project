import 'package:food_delivery_app/model/burger_model.dart';

List<BurgerModel> getBurger() {
  List<BurgerModel> burger = [];
  BurgerModel burgerModel = new BurgerModel();

  burgerModel.name = "Cheese Burger";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "50";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Cheese Burger";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "90";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Cheese Burger";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "40";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Cheese Burger";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "70";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Cheese Burger";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "80";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();

  burgerModel.name = "Cheese Burger";
  burgerModel.image = "images/burger2.png";
  burgerModel.price = "45";
  burger.add(burgerModel);
  burgerModel = new BurgerModel();
  return burger;
}
