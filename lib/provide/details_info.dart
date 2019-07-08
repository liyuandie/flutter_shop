import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/details_madel.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  // 从后台获取商品详情信息
  getGoodsDetailInfo(String id) {
    var formData = {'goodId': id};
    getGoodsDetail(formData).then((val) {
      var responseData = json.decode(val.toString());

      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
    });
  }
}
