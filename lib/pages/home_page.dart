import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String homePageContent = '正在获取数据';

  // @override
  // void initState() {
  //   getHomePageContent().then((val) {
  //     setState(() {
  //       homePageContent = val.toString();
  //     });
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('百姓生活+'),
        ),
        body: FutureBuilder(
          future: getHomePageContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              return Column(
                children: <Widget>[
                  HomeSwiper(
                    swiperDataList: swiper,
                  )
                ],
              );
            } else {
              return Center(
                child: Text('加载中'),
              );
            }
          },
        ));
  }
}

//首页轮播组件
class HomeSwiper extends StatelessWidget {
  final List swiperDataList;

  HomeSwiper({this.swiperDataList});

  @override
  Widget build(BuildContext context) {
    // var s_height = ScreenUtil.screenHeight;
    // var s_width = ScreenUtil.screenWidth;
    // print('屏幕高度：$s_height');
    // print('屏幕宽度：$s_width');
    ScreenUtil.instance = ScreenUtil(height: 1334, width: 750)..init(context);
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            '${swiperDataList[index]['image']}',
            fit: BoxFit.cover,
          );
        },
        itemCount: swiperDataList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
