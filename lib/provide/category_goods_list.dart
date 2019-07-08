import 'package:flutter/material.dart';
import '../model/mallGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<MallGoodsListData> goodsList = [];
  //点击大类时更换商品列表
  changeGoodsList(List<MallGoodsListData> list) {
    goodsList = list;
    notifyListeners();
  }
}
