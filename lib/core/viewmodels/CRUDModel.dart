import 'dart:async';
import 'package:flutter/material.dart';
import 'package:resturent_app/core/models/RestauranttModel.dart' as prefix0;
import '../../locator.dart';
import '../services/api.dart';
import '../models/RestauranttModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDModel extends ChangeNotifier {
  Api _api = locator<Api>();

  List<Restaurant> restaurants;

  Restaurant _restaurant;

  set restaurant(Restaurant value) {
    _restaurant = value;
  }

  get restaurant {
    return _restaurant;
  }

  Future<List<Restaurant>> fetchProducts() async {
    var result = await _api.getDataCollection();
    restaurants = result.documents
        .map((doc) => Restaurant.fromMap(doc.data, doc.documentID))
        .toList();
    return restaurants;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    var result = _api.streamDataCollection();

    result.listen((onData) {
      restaurants = onData.documents
          .map((doc) => Restaurant.fromMap(doc.data, doc.documentID))
          .toList();
    });

    return result;
  }

  Future<Restaurant> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return Restaurant.fromMap(doc.data, doc.documentID);
  }

  Future removeProduct(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateProduct(Restaurant data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addProduct(Restaurant data) async {
    print("Json ::::::::::::::::::::::::  :   ");
    print(data.toJson());
    var result = await _api.addDocument(data.toJson());

    return;
  }
}
