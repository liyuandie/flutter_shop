import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
        color: Colors.white,
        child: Provide<CartProvide>(
          builder: (context, child, val) {
            return Row(
              children: <Widget>[
                _selectAllBtn(),
                _allPrice(context),
                _accountBtn(context)
              ],
            );
          },
        ));
  }

  //复选框
  Widget _selectAllBtn() {
    return Container(
      width: ScreenUtil().setWidth(150),
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true,
            activeColor: Colors.pink,
            onChanged: (bool val) {},
          ),
          Container(
            child: Text('全选'),
          )
        ],
      ),
    );
  }

  // 价格
  Widget _allPrice(context) {
    return Container(
      width: ScreenUtil().setWidth(430),
      padding: EdgeInsets.only(right: 20.0),
      // color: Colors.pink,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                child: Text(
                  '合计：',
                  style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                ),
              ),
              Container(
                child: Text(
                  Provide.value<CartProvide>(context).totalPrice.toString(),
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(35), color: Colors.red),
                ),
              )
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                  color: Colors.black38, fontSize: ScreenUtil().setSp(22)),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }

  // 结算
  Widget _accountBtn(context) {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3.0)),
          child: Text(
            '结算(${Provide.value<CartProvide>(context).totalCount.toString()})',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
