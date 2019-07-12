import 'package:flutter/material.dart';
import '../model/mallGoodsList.dart';
import 'package:provide/provide.dart';
import './childCategory.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<MallGoodsListData> goodsList = [];
  List list = [];
  var currentIndex = 0;
  //点击大类时更换商品列表
  changeGoodsList(context) async {
    var formData = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).categorySubId,
      'page': 1,
    };
    print(formData.toString());
    return await getMallGoods(formData).then((val) {
      var data = json.decode(val.toString());
      MallGoodsListModel list = MallGoodsListModel.fromJson(data);
      goodsList = list.data;
      notifyListeners();
    });
  }

  loadMoreGoodsList(context) async {
    Provide.value<ChildCategory>(context).addPage();
    var formData = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).categorySubId,
      'page': Provide.value<ChildCategory>(context).page,
    };
    return await getMallGoods(formData).then((val) {
      var data = json.decode(val.toString());
      MallGoodsListModel newList = MallGoodsListModel.fromJson(data);
      if (newList.data == null) {
        return Provide.value<ChildCategory>(context).changeoMoreText('没有更多了');
      } else {
        goodsList.addAll(newList.data);
      }
      notifyListeners();
    });
  }

  //获取左侧大类
  getCategory(context) async {
    await getCategoryPageContent().then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      // list.data.forEach((item) => print(item.mallCategoryName));

      list = category.data;

      Provide.value<ChildCategory>(context).getChildCategory(
          category.data[0].bxMallSubDto, category.data[0].mallCategoryId);
    });
    notifyListeners();
    return list;
  }
  // 改变当前大类索引

  changeCurrentIndex(index) {
    currentIndex = index;
    notifyListeners();
  }

  clearGoodsList() {
    goodsList = [];
    notifyListeners();
  }
}
