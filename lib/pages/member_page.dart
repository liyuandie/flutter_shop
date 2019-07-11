import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[_avatar(), _orderArea(), _listArea()],
      ),
    );
  }

  _avatar() {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=277237570,297498983&fm=26&gp=0.jpg',
              ))),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(350),
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(180),
            margin: EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.white),
                borderRadius: BorderRadius.circular(60)),
            child: ClipOval(
              child: Image.network(
                  'https://tvax4.sinaimg.cn/crop.0.0.1002.1002.180/0064snFfly8fynhndio35j30ru0rutas.jpg?Expires=1562819117&ssig=zKBqcA6ovy&KID=imgbed,tva'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text('桥豆麻袋',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(35), color: Colors.black87)),
          )
        ],
      ),
    );
  }

  _orderArea() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.black12))),
            child: ListTile(
              title: Text('我的订单'),
              leading: Icon(Icons.assignment),
              trailing: Icon(CupertinoIcons.right_chevron),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Icon(
                          Icons.description,
                          size: 30,
                        ),
                      ),
                      Container(
                        child: Text('待付款'),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Icon(
                          Icons.query_builder,
                          size: 30,
                        ),
                      ),
                      Container(
                        child: Text('待发货'),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Icon(
                          Icons.departure_board,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        child: Text('待收货'),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Icon(
                          Icons.content_paste,
                          size: 30,
                        ),
                      ),
                      Container(
                        child: Text('待评价'),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _listArea() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black12))),
                child: ListTile(
                  leading: Icon(Icons.card_giftcard),
                  title: Text('领取优惠券'),
                  trailing: Icon(CupertinoIcons.right_chevron),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black12))),
                child: ListTile(
                  leading: Icon(Icons.card_giftcard),
                  title: Text('已领取优惠券'),
                  trailing: Icon(CupertinoIcons.right_chevron),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black12))),
                child: ListTile(
                  leading: Icon(Icons.card_giftcard),
                  title: Text('地址管理'),
                  trailing: Icon(CupertinoIcons.right_chevron),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black12))),
                child: ListTile(
                  leading: Icon(Icons.card_giftcard),
                  title: Text('联系我们'),
                  trailing: Icon(CupertinoIcons.right_chevron),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom: BorderSide(width: 0.5, color: Colors.black12))),
                child: ListTile(
                  leading: Icon(Icons.card_giftcard),
                  title: Text('关于商城'),
                  trailing: Icon(CupertinoIcons.right_chevron),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
