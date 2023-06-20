import 'dart:developer';
import 'dart:ui';

import 'package:esptiles/models/category_model.dart';
import 'package:esptiles/models/product_model.dart';
import 'package:esptiles/models/subcategory_model.dart';
import 'package:esptiles/services/category.dart';
import 'package:esptiles/services/product.dart';
import 'package:esptiles/services/subcategory.dart';
import 'package:esptiles/widgets/product.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Category_model> categoryList = [];
  List<SubcategoryModle> subcategorylList = [];
  List<ProductModel> productList = [];
  var curruntSategoryindex = 0;
  var loading = true;
  int curruntindex = 0;
  // GetSubCategory getSubCategory = GetSubCategory();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    GetCategory getCategory = GetCategory();
    categoryList = await getCategory.getdata();
    log(categoryList[0].name.toString());

    subcategorylList = await GetSubCategory().getdata(categoryList[0].id);
    setState(() {
      loading = false;
    });
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
            padding: const EdgeInsets.only(top: 130.0),
            child: Container(
              height: 200,
              alignment: Alignment.bottomCenter,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: ((context, index) => GestureDetector(
                        onTap: () async {
                    
                          subcategorylList = await GetSubCategory()
                              .getdata(categoryList[index].id);

                          setState(() {
                            setindex(index);
                          });
                        
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
            ? Container(
                alignment: Alignment.center,
                height: 20,
                child: CircularProgressIndicator(),
              )
            : Subcategory(
                list: subcategorylList,
              ));
  }

  void setindex(int index) {
    log(curruntindex.toString());
    setState(() {
      curruntindex = index;
      loading = false;
    });
  }
}

class Subcategory extends StatefulWidget {
  final List<SubcategoryModle> list;
  const Subcategory({super.key, required this.list});

  @override
  State<Subcategory> createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
  bool loading = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list.length,
      itemBuilder: ((context, index){ 
      
        return Product ( key: Key(index.toString()),id:  widget.list[index].id , name:widget.list[index].name);}),
    );
  }
}
