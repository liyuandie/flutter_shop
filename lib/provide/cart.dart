import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/cart_info.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';

  List<CartInfoModel> cartList = [];

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
        'images': images
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
      tempList.forEach((item) {
        cartList.add(CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
  }
}
