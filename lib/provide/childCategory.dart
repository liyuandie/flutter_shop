import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  int childIndex = 0;
  getChildCategory(List<BxMallSubDto> list) {
    childIndex = 0;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.comments = null;
    all.mallSubName = '全部';

    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引

  changeChildIndex(index) {
    childIndex = index;
    notifyListeners();
  }
}
