import 'dart:convert';
import 'dart:developer';

import 'package:esptiles/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetCategory {
  List<Category_model> Data = [];

  Future<List<Category_model>> getdata() async {
    //fuction for get product using categoryid
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Basic Y2tfMmNhODJlNjQyNjBkYzVjYjY0NDhkZGMzMjlmOTE5MGQwNGU4ZDYxYjpjc18xMmQ3ZWM1YzI4OWQxZTYzNzI3ODg1NTM2NGNkZmVkYTU0ODI4YWI4'
    };
    var request = http.Request('POST',
        Uri.parse('http://esptiles.imperoserver.in/api/API/Product/DashBoard'));
    request.body = json.encode({
      "CategoryId": 0,
      "DeviceManufacturer": "Google",
      "DeviceModel": "Android SDK built for x86",
      "DeviceToken": " ",
      "PageIndex": 1
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      print(await response.body);
    } else {
      print(response.reasonPhrase);
    }

    var temp = json.decode(response.body);

    temp['Result']['Category'].forEach((element) {
      Data.add(Category_model(
          element['Name'], element['Id']));
    });
    return Data;
  }
}
