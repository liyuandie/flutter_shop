import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    print('页面初始化'); //测试是否保持页面状态
  }

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
              //处理数据
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();
              String adPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast();
              recommendList.add(recommendList[0]);
              recommendList.add(recommendList[1]);

              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    HomeSwiper(
                      swiperDataList: swiper,
                    ),
                    TopNavigator(navigatorList: navigatorList),
                    AdBanner(
                      adPicture: adPicture,
                    ),
                    LeaderPhone(
                      leaderImage: leaderImage,
                      leaderPhone: leaderPhone,
                    ),
                    Recommond(recommendList: recommendList)
                  ],
                ),
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

//商品类别目录
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({this.navigatorList});

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      this.navigatorList.removeRange(10, navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

//广告bannner
class AdBanner extends StatelessWidget {
  final String adPicture;
  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: 10.0),
      child: Image.network(adPicture),
    );
  }
}

//店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;
  LeaderPhone({this.leaderImage, this.leaderPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw '拨打电话失败，请稍后再试或手动拨打$leaderPhone';
      }
    } catch (e) {
      return print(e);
    }
  }
}

class Recommond extends StatelessWidget {
  List recommendList;
  Recommond({this.recommendList});
// 标题方法
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 5.0, 0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pinkAccent),
      ),
    );
  }

// 商品单独项方法
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                  color: Colors.grey, decoration: TextDecoration.lineThrough),
            ),
            Text(
              '${recommendList[index]['goodsName']}',
              maxLines: 2,
              overflow: TextOverflow.visible,
              style: TextStyle(fontSize: 10.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  //横向列表
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(330),
      // margin: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      height: ScreenUtil().setHeight(380),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[_titleWidget(), _recommendList()],
      )),
    );
  }
}
