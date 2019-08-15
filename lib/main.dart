import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resturent_app/ui/views/homeView.dart';
import './locator.dart';
import './core/viewmodels/CRUDModel.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => locator<CRUDModel>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Product App',
        theme: ThemeData(),
        home: HomeView(),
      ),
    );
  }
}
