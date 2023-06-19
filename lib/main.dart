import 'dart:developer';

import 'package:esptiles/models/category_model.dart';
import 'package:esptiles/models/product_model.dart';
import 'package:esptiles/models/subcategory_model.dart';
import 'package:esptiles/services/category.dart';
import 'package:esptiles/services/product.dart';
import 'package:esptiles/services/subcategory.dart';
import 'package:esptiles/widgets/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
    debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 7, 7, 153)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

