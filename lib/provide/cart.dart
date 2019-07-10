import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cart_info.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';

  List<CartInfoModel> cartList = [];

  double totalPrice = 0.0; //总价
  int totalCount = 0;
  bool isAllCheck = true; // 是否全选

  save(goodsId, goodsName, count, oriPrice, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();

    bool isHave = false;
    int i = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[i]['count'] = item['count'] + 1;
        cartList[i].count++;
        isHave = true;
      }
      i++;
    });
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'oriPrice': oriPrice,
        'price': price,
        'images': images,
        'isCheck': true
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));
    }
    cartString = json.encode(tempList).toString();
    // print(cartString);
    prefs.setString('cartInfo', cartString);
    notifyListeners();
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = [];
    print('清除完成----------------------------');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString) as List).cast();
      totalCount = 0;
      totalPrice = 0.0;
      isAllCheck = true;

      tempList.forEach((item) {
        if (item['isCheck']) {
          totalPrice += (item['count'] * item['price']);
          totalCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }
  // 删除商品

  deleteGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();

    int index = 0;
    int detIndex = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        detIndex = index;
      }
    });
    tempList.removeAt(detIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    getCartInfo();
  }

  // 改变商品Check状态
  changeCheckState(CartInfoModel goods) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();

    int index = 0;
    int changeIndex = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == goods.goodsId) {
        changeIndex = index;
      }
      index++;
    });
    tempList[changeIndex] = goods.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 全选商品
  allCheck(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 改变商品数量
  changeGoodsCount(CartInfoModel goods, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();

    int index = 0;
    int changeIndex = 0;

    tempList.forEach((item) {
      if (item['goodsId'] == goods.goodsId) {
        changeIndex = index;
      }
      index++;
    });

    if (type == 'add') {
      goods.count++;
    } else if (goods.count > 1) {
      goods.count--;
    }
    tempList[changeIndex] = goods.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }
}
