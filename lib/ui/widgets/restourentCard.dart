import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturent_app/core/models/RestauranttModel.dart';
import 'package:resturent_app/core/viewmodels/CRUDModel.dart';
import 'package:resturent_app/ui/views/Menue.dart';

class ResturenCard extends StatelessWidget {
  final Restaurant productDetails;

  ResturenCard({@required this.productDetails});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<CRUDModel>(context);

    return GestureDetector(
      onTap: () {
        if (productDetails.menu.length > 0) {
          productProvider.restaurant = productDetails;
        } else {
          productProvider.restaurant = Restaurant(
            id: productDetails.id,
              name: productDetails.name,
              menu: [],
              img: productDetails.img,
              fans: productDetails.fans);
          print("No items");
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Menue()),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 5,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              children: <Widget>[
                Image.network(
                  productDetails.img,
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        productDetails.name,
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.person),
                          Text(
                            productDetails.fans,
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 22,
                                fontStyle: FontStyle.italic,
                                color: Colors.orangeAccent),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
