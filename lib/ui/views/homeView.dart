import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:resturent_app/core/models/RestauranttModel.dart';
import 'package:resturent_app/core/viewmodels/CRUDModel.dart';
import 'package:resturent_app/ui/widgets/restourentCard.dart';

import 'addResrourent.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Restaurant> restaurants;

  @override
  Widget build(BuildContext context) {
    final restourentProvider = Provider.of<CRUDModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddResrourent()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Center(child: Text('Home')),
      ),
      body: Container(
        child: StreamBuilder(
            stream: restourentProvider.fetchProductsAsStream(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                restaurants = snapshot.data.documents
                    .map((doc) => Restaurant.fromMap(doc.data, doc.documentID))
                    .toList();
                return ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (buildContext, index) {
                      return ResturenCard(productDetails: restaurants[index]);
                    });
              } else {
                return Text('fetching');
              }
            }),

//        child: FutureBuilder(
//            future: productProvider.fetchProducts(),
//            builder: (context, snapshot) {
//              if (snapshot.hasData) {
//                products = snapshot.data;
//
//                return ListView.builder(
//                  itemCount: products.length,
//                  itemBuilder: (buildContext, index) =>
//                      ProductCard(productDetails: products[index]),
//                );
//              } else {
//                return Text('fetching');
//              }
//            }),
      ),
    );
  }
}
