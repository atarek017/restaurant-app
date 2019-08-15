import 'package:flutter/material.dart';
import 'package:resturent_app/core/models/RestauranttModel.dart';

class MenuCard extends StatelessWidget {
  final Menu menu;

  MenuCard(this.menu);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 5,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Image.network(
                    menu.img,
                    height: 100,
                    width: 100,
                  ),
                  Text(menu.name),
                  Text(menu.price + " \$"),
                ],
              ),
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: 130,
                      child: Text(
                    menu.description,
                  )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
