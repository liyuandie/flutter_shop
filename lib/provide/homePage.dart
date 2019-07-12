import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/homeContent.dart';
import '../model/hotGoods.dart';

class HomePageContentProvide with ChangeNotifier {
  // HomePageContentModel homePageContentData;
  int page = 1;
  List<HotGoodsData> hotGoodsList = [];

  // getHomePage() async {
  //   await getHomePageContent().then((val) {
  //     var homePageContent = json.decode(val.toString());
  //     homePageContentData = HomePageContentModel.fromJson(homePageContent);
  //     notifyListeners();
  //   });
  // }

  getHotGoods() async {
    var formData = {'page': 1};

    await getHomePageBelowContent(formData).then((val) {
      var hotGoodsData = json.decode(val.toString());
      // print(hotGoodsData);
      hotGoodsList = HotGoodsModel.fromJson(hotGoodsData).data;
      page = 1;
      notifyListeners();
    });
  }

  loadMoreHotGoods() async {
    var formData = {'page': page + 1};

    return await getHomePageBelowContent(formData).then((val) {
      var hotGoodsData = json.decode(val.toString());
      // print(hotGoodsData);
      var newList = HotGoodsModel.fromJson(hotGoodsData).data;
      hotGoodsList.addAll(newList);
      page++;
      notifyListeners();
    });
  }
}
