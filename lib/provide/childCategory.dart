import 'package:flutter/material.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];

  int childIndex = 0;
  String categoryId = '4'; //大类Id
  String categorySubId = ''; //小类Id
  int page = 1; //列表页数
  String noMoreText = ''; //没有数据时显示的文字

  // 切换大类
  getChildCategory(List<BxMallSubDto> list, String id) {
    childIndex = 0;
    categoryId = id;
    page = 1;
    noMoreText = '';
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '';
    all.mallCategoryId = '00';
    all.comments = null;
    all.mallSubName = '全部';

    childCategoryList = [all];
    childCategoryList.addAll(list);
    categorySubId = '';
    notifyListeners();
  }

  //改变子类索引

  changeChildIndex(index, String id) {
    childIndex = index;
    categorySubId = id;
    page = 1;
    noMoreText = '';

    notifyListeners();
  }

  //增加page的方法

  addPage() {
    page++;
    notifyListeners();
  }

  changeoMoreText(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
