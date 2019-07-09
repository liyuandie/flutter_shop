import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DetailsTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailInfoProvide>(
      builder: (context, child, data) {
        var goodsInfo =
            Provide.value<DetailInfoProvide>(context).goodsInfo.data.goodInfo;
        if (goodsInfo != null) {
          return Container(
            padding: EdgeInsets.all(2.0),
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1, context),
                _goodsName(goodsInfo.goodsName),
                _goodsId(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
              ],
            ),
          );
        } else {
          return Center(
            child: Text('加载中...'),
          );
        }
      },
    );
  }

//s商品地址
  Widget _goodsImage(url, context) {
    List<String> goodsImageList = [];
    var goodsInfo =
        Provide.value<DetailInfoProvide>(context).goodsInfo.data.goodInfo;
    goodsImageList
      ..add(goodsInfo.image1)
      ..add(goodsInfo.image1)
      ..add(goodsInfo.image1)
      ..add(goodsInfo.image1);
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(580),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            goodsImageList[index],
            fit: BoxFit.cover,
          );
        },
        itemCount: goodsImageList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }

//商品名称
  Widget _goodsName(name) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(30.0)),
      ),
    );
  }

  // 商品编号

  Widget _goodsId(id) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.fromLTRB(15.0, 8.0, 0, 0),
      child: Text('编号:${id}', style: TextStyle(color: Colors.black26)),
    );
  }

  //商品价格方法

  Widget _goodsPrice(presentPrice, oriPrice) {
    return Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 8.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '￥${presentPrice}',
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
          Text(
            '市场价:￥${oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}
