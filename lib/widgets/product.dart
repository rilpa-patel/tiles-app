import 'dart:developer';

import 'package:esptiles/models/product_model.dart';
import 'package:esptiles/services/product.dart';
import 'package:flutter/material.dart';

class Product extends StatefulWidget {
  final int id;
  final String name;
  const Product({super.key, required this.id, required this.name});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  List<ProductModel> productList = [];
  bool loading = true;
  @override
  void initState() {
    print("init");
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    log(widget.id.toString());
    GetProduct getProduct = GetProduct();
    productList = await getProduct.getdata(widget.id);
    setState(() {
      loading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : Column(
          
          children: [
            Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
            Container(
              height: 110,
              child: ListView.builder(
                  itemCount: productList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Stack(
                          children: [
                            Container(
                                height: 70,
                                width: 90,
                                child: Image.network(productList[index].image)),
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
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(productList[index].name),
                      )
                    ]);
                  }),
            ),
          ],
        );
  }
}
