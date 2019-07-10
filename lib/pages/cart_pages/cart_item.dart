import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart_info.dart';
import '../../provide/cart.dart';
import './cart_count.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;

  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    // print(item);
    return Container(
      margin: EdgeInsets.fromLTRB(0, 2.0, 0, 2.0),
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _cartCheckBtn(),
          _cartImage(),
          _cartGoodsName(),
          _cartPrice()
        ],
      ),
    );
  }

  // 复选按钮
  Widget _cartCheckBtn() {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {},
      ),
    );
  }

  // 商品图片
  Widget _cartImage() {
    return Container(
      height: ScreenUtil().setHeight(130),
      padding: EdgeInsets.all(3.0),
      decoration:
          BoxDecoration(border: Border.all(width: 0.5, color: Colors.black12)),
      child: Image.network(item.images),
    );
  }

  //商品名称
  Widget _cartGoodsName() {
    return Container(
      width: ScreenUtil().setWidth(300),
      height: ScreenUtil().setHeight(130),
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            item.goodsName,
            style: TextStyle(fontSize: ScreenUtil().setSp(27)),
          ),
          CartCount(),
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice() {
    return Container(
      width: ScreenUtil().setWidth(150),
      // height: ScreenUtil().setHeight(100),
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text('￥ ${item.price}',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      fontWeight: FontWeight.w300)),
              Text(
                '￥ ${item.oriPrice}',
                style: TextStyle(
                    color: Colors.black26,
                    fontSize: ScreenUtil().setSp(24),
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          Container(
              padding: EdgeInsets.only(top: 15),
              child: InkWell(
                onTap: () {},
                child: Icon(
                  Icons.delete,
                  color: Colors.black26,
                  size: 25,
                ),
              ))
        ],
      ),
    );
  }
}
