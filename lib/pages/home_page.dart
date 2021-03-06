import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../route/application.dart';
import '../provide/homePage.dart';
import '../provide/childCategory.dart';
import '../provide/category_goods_list.dart';
import '../model/homeContent.dart';
import '../provide/router.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  GlobalKey<RefreshFooterState> _footerkey =
      new GlobalKey<RefreshFooterState>();
  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
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
              var data = (HomePageContentModel.fromJson(
                      json.decode((snapshot.data).toString())))
                  .data;
              List swiper = data.slides;
              List navigatorList = data.category;
              String adPicture = data.advertesPicture.pICTUREADDRESS;
              String leaderImage = data.shopInfo.leaderImage;
              String leaderPhone = data.shopInfo.leaderPhone;
              List recommendList = data.recommend;
              String floor1Title = data.floor1Pic.pICTUREADDRESS;
              List floor1 = data.floor1;
              String floor2Title = data.floor2Pic.pICTUREADDRESS;
              List floor2 = data.floor2;
              String floor3Title = data.floor3Pic.pICTUREADDRESS;
              List floor3 = data.floor3;

              return EasyRefresh(
                refreshFooter: ClassicsFooter(
                  bgColor: Colors.white,
                  textColor: Colors.black38,
                  moreInfoColor: Colors.black38,
                  showMore: true,
                  noMoreText: '已经到底啦',
                  moreInfo: '加载中...',
                  loadReadyText: '松手加载',
                  loadText: '上拉加载更多',
                  loadingText: '加载中...',
                  loadedText: '加载成功',
                  key: _footerkey,
                ),
                child: ListView(
                  children: <Widget>[
                    HomeSwiper(
                      swiperDataList: swiper,
                    ),
                    TopNavigator(navigatorList: navigatorList),
                    AdBanner(
                      adPicture,
                    ),
                    LeaderPhone(
                      leaderImage: leaderImage,
                      leaderPhone: leaderPhone,
                    ),
                    Recommond(recommendList),
                    FloorTitle(
                      pictrueAddress: floor1Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor1,
                    ),
                    FloorTitle(
                      pictrueAddress: floor2Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor2,
                    ),
                    FloorTitle(
                      pictrueAddress: floor3Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor3,
                    ),
                    HotGoods()
                  ],
                ),
                loadMore: () async {
                  await Provide.value<HomePageContentProvide>(context)
                      .loadMoreHotGoods();
                },
                onRefresh: () async {
                  await getHomePageContent();
                  await Provide.value<HomePageContentProvide>(context)
                      .getHotGoods();
                },
                refreshHeader: ClassicsHeader(
                  bgColor: Colors.white,
                  key: _headerKey,
                  textColor: Colors.black38,
                  refreshingText: '加载中...',
                  refreshText: '下拉释放刷新',
                  refreshReadyText: '释放刷新',
                  refreshedText: '刷新成功',
                ),
              );
            } else {
              return Center(
                child: Text('加载中...'),
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
          return InkWell(
            onTap: () {
              Application.router.navigateTo(
                  context, '/detail?id=${swiperDataList[index]['goodsId']}');
            },
            child: Image.network(
              '${swiperDataList[index].image}',
              fit: BoxFit.cover,
            ),
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
        // var list = Provide.value<CategoryGoodsListProvide>(context).list;
        // var categoryId = item.mallCategoryId;
        print('点击了导航');
        Provide.value<RouterProvide>(context).changeIndex(1);
        // Provide.value<CategoryGoodsListProvide>(context)
        //     .changeCurrentIndex(item);
        //  Provide.value<ChildCategory>(context)
        //     .getChildCategory(childList, item.mallCategoryId);
        // Provide.value<CategoryGoodsListProvide>(context)
        //           .changeGoodsList(context);
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item.image,
            width: ScreenUtil().setWidth(95),
          ),
          Text(item.mallCategoryName)
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
        physics: NeverScrollableScrollPhysics(),
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
  AdBanner(this.adPicture);

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

//商品推荐
class Recommond extends StatelessWidget {
  List<Recommend> recommendList;
  Recommond(this.recommendList);
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
  Widget _item(context, index) {
    return InkWell(
      onTap: () {
        Application.router
            .navigateTo(context, '/detail?id=${recommendList[index].goodsId}');
      },
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
            Image.network(recommendList[index].image),
            Text('￥${recommendList[index].mallPrice}'),
            Text(
              '￥${recommendList[index].price}',
              style: TextStyle(
                  color: Colors.grey, decoration: TextDecoration.lineThrough),
            ),
            Text(
              '${recommendList[index].goodsName}',
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
        // physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(context, index);
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
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: <Widget>[_titleWidget(), _recommendList()],
          )),
    );
  }
}

// 楼层标题
class FloorTitle extends StatelessWidget {
  final String pictrueAddress;
  FloorTitle({this.pictrueAddress});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(pictrueAddress),
    );
  }
}

// 楼层商品列表

class FloorContent extends StatelessWidget {
  List floorGoodsList;

  FloorContent({this.floorGoodsList});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[_firstRow(context), _otherGoods(context)],
      ),
    );
  }

  Widget _goodsItem(context, goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      // height: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          Application.router.navigateTo(context, '/detail?id=${goods.goodsId}');
        },
        child: Image.network(goods.image),
      ),
    );
  }

  Widget _firstRow(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context, floorGoodsList[1]),
            _goodsItem(context, floorGoodsList[2])
          ],
        )
      ],
    );
  }

  Widget _otherGoods(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodsList[3]),
        _goodsItem(context, floorGoodsList[4])
      ],
    );
  }
}

class HotGoods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provide.value<HomePageContentProvide>(context).getHotGoods();
    return Provide<HomePageContentProvide>(
      builder: (context, child, val) {
        return Container(
          child: Column(children: <Widget>[_hotTitle, _wrapList(context)]),
        );
      },
    );
  }

  Widget _hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    child: Text(
      '火爆专区',
      style: TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
    ),
    padding: EdgeInsets.only(bottom: 5.0),
  );

  Widget _wrapList(context) {
    var hotGoodsList =
        Provide.value<HomePageContentProvide>(context).hotGoodsList;
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {
            Application.router.navigateTo(context, '/detail?id=${val.goodsId}');
          },
          child: Container(
            width: ScreenUtil().setWidth(370),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val.image,
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  val.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '￥${val.price}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough),
                    ),
                    Text('￥${val.mallPrice}'),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('暂无推荐商品');
    }
  }
}
