import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provide/provide.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsExplainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(740),
      color: Colors.white,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      child: Text(
        '说明：>急速送达 >正品保证',
        style: TextStyle(
            color: Colors.redAccent, fontSize: ScreenUtil().setSp(27)),
      ),
    );
  }
}
