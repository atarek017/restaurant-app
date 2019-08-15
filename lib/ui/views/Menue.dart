import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturent_app/core/models/RestauranttModel.dart';
import 'package:resturent_app/core/viewmodels/CRUDModel.dart';
import 'package:resturent_app/ui/widgets/menuCard.dart';

import 'addMenu.dart';

class Menue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final restourentProvider = Provider.of<CRUDModel>(context);

    List<Menu> menu = restourentProvider.restaurant.menu;

    return Scaffold(
      appBar: AppBar(title: Text(restourentProvider.restaurant.name+" Menu"),centerTitle: true,),
      body: Container(
        child: ListView.builder(
          itemCount: menu.length,
          itemBuilder: (context , index){
            return MenuCard(menu[index]);
          },
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMenu()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
