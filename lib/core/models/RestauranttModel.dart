import 'dart:convert';

class Restaurant {
  String id;
  String fans;
  String name;
  List<Menu> menu;
  String img;

  Restaurant({this.id, this.fans, this.name, this.img, this.menu});

  Restaurant.fromMap(Map snapshot, String id) {
    this.id = id ?? '';
    fans = snapshot['fans'] ?? '';
    name = snapshot['name'] ?? '';
    img = snapshot['img'] ?? '';
    List<dynamic> tempList = snapshot['menu'];
    menu = tempList.map((menuList) => Menu.fromMap(menuList)).toList();
  }

  Map<String, dynamic>  toJson() {
    return {
      "fans": fans,
      "name": name,
      "menu": menu.map((v) => v.toJson()).toList(),
      "img": img,
    };
  }
}

class Menu {
  String name;
  String price;
  String description;
  String img;

  Menu({this.name, this.price, this.description, this.img});

  Menu.fromMap(Map snapshot)
      : name = snapshot['name'],
        img = snapshot['img'],
        description = snapshot['description'],
        price = snapshot['price'];

  Map<String, dynamic> toJson() {
    return {
      "price": price,
      "img": img,
      "description": description,
      "name": name,
    };
  }
}
