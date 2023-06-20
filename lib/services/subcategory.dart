import 'dart:convert';
import 'dart:developer';

import 'package:esptiles/models/category_model.dart';
import 'package:esptiles/models/subcategory_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetSubCategory {
  List<SubcategoryModle> data = [];

  Future<List<SubcategoryModle>> getdata(int id) async {
    //fuction for get product using categoryid
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Basic Y2tfMmNhODJlNjQyNjBkYzVjYjY0NDhkZGMzMjlmOTE5MGQwNGU4ZDYxYjpjc18xMmQ3ZWM1YzI4OWQxZTYzNzI3ODg1NTM2NGNkZmVkYTU0ODI4YWI4'
    };
    var request = http.Request('POST',
        Uri.parse('http://esptiles.imperoserver.in/api/API/Product/DashBoard'));
    request.body = json.encode({"CategoryId": id, "PageIndex": 2});
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print( response.body);
    } else {
      print(response.reasonPhrase);
    }

    var temp = json.decode(response.body);

    temp['Result']['Category'].forEach((element) {
      print("bhui");
      log(element['SubCategories']. toString());
              // Data.add(SubcategoryModle(element['SubCategories']['Id'], element['SubCategories']['Name']));

      element['SubCategories']?.forEach((value){
              data.add(SubcategoryModle(value['Id'], value['Name']));
      });
    });

    return data;
  }
}
