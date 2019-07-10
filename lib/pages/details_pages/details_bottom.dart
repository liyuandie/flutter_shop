import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import '../../provide/cart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/router.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provide.value<DetailInfoProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;
    var oriPrice = goodsInfo.oriPrice;
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(100),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              Provide.value<RouterProvide>(context).changeIndex(2);
              Navigator.pop(context);
            },
            child: Container(
              width: ScreenUtil().setWidth(130.0),
              alignment: Alignment.center,
              child: Icon(Icons.shopping_cart, size: 35, color: Colors.red),
            ),
          ),
          InkWell(
            onTap: () {
              Provide.value<CartProvide>(context)
                  .save(goodsId, goodsName, count, oriPrice, price, images);
            },
            child: Container(
              width: ScreenUtil().setWidth(310),
              color: Colors.green,
              height: ScreenUtil().setHeight(100),
              alignment: Alignment.center,
              child: Text('加入购物车',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(30))),
            ),
          ),
          InkWell(
            onTap: () {
              Provide.value<CartProvide>(context).clear();
            },
            child: Container(
              width: ScreenUtil().setWidth(310),
              color: Colors.red,
              height: ScreenUtil().setHeight(100),
              alignment: Alignment.center,
              child: Text('立即购买',
                  style: TextStyle(
                      color: Colors.white, fontSize: ScreenUtil().setSp(30))),
            ),
          )
        ],
      ),
    );
  }
}
