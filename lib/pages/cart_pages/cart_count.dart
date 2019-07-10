import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class CartCount extends StatelessWidget {
  CartInfoModel item;
  CartCount(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(145),
      decoration:
          BoxDecoration(border: Border.all(width: 1.0, color: Colors.black12)),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(context),
          _addBtn(context)
        ],
      ),
    );
  }

  // 减少按钮
  Widget _reduceBtn(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).changeGoodsCount(item, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            // color: item.count > 1 ? Colors.white : Colors.black12,
            border:
                Border(right: BorderSide(width: 1.0, color: Colors.black12))),
        child: Text('—'),
      ),
    );
  }

  // 增加按钮
  Widget _addBtn(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).changeGoodsCount(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border:
                Border(left: BorderSide(width: 1.0, color: Colors.black12))),
        child: Text('+'),
      ),
    );
  }

  //数量显示区域
  Widget _countArea(context) {
    return Container(
      width: ScreenUtil().setWidth(50),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        item.count.toString(),
        style: TextStyle(fontSize: ScreenUtil().setSp(25)),
      ),
    );
  }
}
