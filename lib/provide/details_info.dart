import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/details_madel.dart';
import '../service/service_method.dart';
import 'dart:convert';

class DetailInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null;

  bool onLeft = true;
  bool onRight = false;

  // 从后台获取商品详情信息
  getGoodsDetailInfo(String id) async {
    var formData = {'goodId': id};
    await getGoodsDetail(formData).then((val) {
      var responseData = json.decode(val.toString());

      goodsInfo = DetailsModel.fromJson(responseData);
      notifyListeners();
      return goodsInfo;
    });
  }
  // tab状态切换

  switchTab(String type) {
    if (type == 'left') {
      onLeft = true;
      onRight = false;
    } else {
      onLeft = false;
      onRight = true;
    }
    notifyListeners();
  }
}
