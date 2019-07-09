import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailInfoProvide>(
      builder: (context, child, val) {
        var onLeft = Provide.value<DetailInfoProvide>(context).onLeft;
        var onRight = Provide.value<DetailInfoProvide>(context).onRight;
        return Container(
          margin: EdgeInsets.only(top: 8.0),
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            children: <Widget>[
              _tab(context, '详情', 'left', onLeft),
              _tab(context, '评论', 'rghit', onRight),
            ],
          ),
        );
      },
    );
  }

  Widget _tab(BuildContext context, String title, String type, bool state) {
    return InkWell(
        onTap: () {
          Provide.value<DetailInfoProvide>(context).switchTab(type);
        },
        child: Container(
          width: ScreenUtil().setWidth(375),
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: state ? Colors.pink : Colors.black12,
            width: 1.0,
          ))),
          child: Text(title,
              style: TextStyle(
                  color: state ? Colors.pink : Colors.black,
                  fontSize: ScreenUtil().setSp(28))),
        ));
  }
}
