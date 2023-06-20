import 'dart:convert';
import 'dart:developer';

import 'package:esptiles/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetProduct {
  List<ProductModel> Data = [];

  Future<List<ProductModel>> getdata(int id) async {
    //fuction for get product using categoryid
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Basic Y2tfMmNhODJlNjQyNjBkYzVjYjY0NDhkZGMzMjlmOTE5MGQwNGU4ZDYxYjpjc18xMmQ3ZWM1YzI4OWQxZTYzNzI3ODg1NTM2NGNkZmVkYTU0ODI4YWI4'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://esptiles.imperoserver.in/api/API/Product/ProductList'));
    request.body = json.encode({"PageIndex": 1, "SubCategoryId": id});

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print(await response.body);
    } else {
      print(response.reasonPhrase);
    }

    var temp = json.decode(response.body);

    temp['Result'].forEach((element) {
      Data.add(ProductModel(
          element['PriceCode'],
          element['ImageName'],
          element['Name']));
    });

    return Data;
  }
}
