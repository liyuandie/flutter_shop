import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provide/cart.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './cart_pages/cart_item.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        body: Provide<CartProvide>(
          builder: (context, child, val) {
            return FutureBuilder(
              future: _getCartInfo(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var cartList = Provide.value<CartProvide>(context).cartList;
                  return ListView.builder(
                    itemCount: cartList.length,
                    itemBuilder: (BuildContext context, index) {
                      return CartItem(cartList[index]);
                    },
                  );
                } else {
                  return Text('加载中');
                }
              },
            );
          },
        ));
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}
