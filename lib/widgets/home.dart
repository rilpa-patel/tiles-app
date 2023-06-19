import 'dart:developer';
import 'dart:ui';

import 'package:esptiles/models/category_model.dart';
import 'package:esptiles/models/product_model.dart';
import 'package:esptiles/models/subcategory_model.dart';
import 'package:esptiles/services/category.dart';
import 'package:esptiles/services/product.dart';
import 'package:esptiles/services/subcategory.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Category_model> categoryList = [];
  var curruntSategoryindex = 0;
  var loading = true;
  int curruntindex = 0;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    GetCategory getCategory = GetCategory();
    categoryList = await getCategory.getdata();
    log(categoryList[0].name.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          actions: [
            Icon(Icons.filter_alt_outlined),
            Padding(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.search),
            )
          ],
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("ESPtiles"),
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 110.0),
            child: Container(
              height: 200,
              alignment: Alignment.bottomCenter,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: ((context, index) => GestureDetector(
                        onTap: () {
                          setindex(index);
                          setState(() {});
                          log(curruntindex.toString());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            categoryList[index].name,
                            style: TextStyle(
                                fontWeight: categoryList[index].name ==
                                        categoryList[curruntindex].name
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ),
                      ))),
            ),
          ),
        ),
        body: loading
            ? CircularProgressIndicator()
            : subcategory(
                id: categoryList[curruntindex].id,
              ));
  }

  void setindex(int index) {
    curruntindex = index;
    log(curruntindex.toString());
    setState(() {});
    loading = false;
  }
}

class subcategory extends StatefulWidget {
  final int id;
  const subcategory({super.key, required this.id});

  @override
  State<subcategory> createState() => _subcategoryState();
}

class _subcategoryState extends State<subcategory> {
  List<SubcategoryModle> subcategorylList = [];

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    GetSubCategory getSubCategory = GetSubCategory();
    log(widget.id.toString());
    subcategorylList = await getSubCategory.getdata(widget.id);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        itemCount: subcategorylList.length,
        itemBuilder: ((context, index) {
          return Container(
            height: 500,
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  subcategorylList[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                // Container(
                //     height: 200, child: Product(id: subcategorylList[index].id))
              ],
            ),
          );
        }),
      ),
    );
  }
}

class Product extends StatefulWidget {
  final int id;
  const Product({super.key, required this.id});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<ProductModel> productList = [];

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    GetProduct getProduct = GetProduct();
    productList = await getProduct.getdata(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: productList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: 500,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    Image.network(productList[index].image),
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(color: Colors.blue),
                      child: Text(productList[index].pricecode),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left : 8.0),
                child: Text(productList[index].name),
              )
            ]),
          );
        });
    ;
  }
}
