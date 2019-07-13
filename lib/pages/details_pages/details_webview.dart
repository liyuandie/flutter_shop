import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';

class DetailsWebview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provide.value<DetailInfoProvide>(context)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail;
    var comment =
        Provide.value<DetailInfoProvide>(context).goodsInfo.data.goodComments;

    return Provide<DetailInfoProvide>(
      builder: (context, child, val) {
        var onLeft = Provide.value<DetailInfoProvide>(context).onLeft;
        Widget _commenItem(context, index) {
          return Container(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1.0, color: Colors.black12))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    comment[index].userName,
                    style: TextStyle(
                        color: Colors.black38, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                  child: Text(comment[index].comments),
                ),
                Container(
                  child: Text(
                    DateTime.fromMillisecondsSinceEpoch(
                      comment[index].discussTime,
                    ).toString().replaceRange(18, 22, ''),
                    style: TextStyle(color: Colors.black38),
                  ),
                )
              ],
            ),
          );
        }

        if (onLeft) {
          return Container(
            child: Html(
              data: goodsDetails,
            ),
          );
        } else {
          if (comment.length > 0) {
            return Container(
              // width: ScreenUtil().setWidth(750),
              height: ScreenUtil().setHeight(2000),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: comment.length,
                itemBuilder: (BuildContext context, index) {
                  return _commenItem(context, index);
                },
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 15.0),
              child: Text(
                '暂时没有评论哦',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(27), color: Colors.black87),
              ),
            );
          }
        }
      },
    );
  }
}
