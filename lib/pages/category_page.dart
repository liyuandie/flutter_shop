import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import '../model/mallGoodsList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/childCategory.dart';
import '../provide/category_goods_list.dart';
import 'package:provide/provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../route/application.dart';

class CategoryPage extends StatelessWidget {
  GlobalKey<RefreshFooterState> _footerkey =
      new GlobalKey<RefreshFooterState>();

  GlobalKey<RefreshHeaderState> _headerKey =
      new GlobalKey<RefreshHeaderState>();

  GlobalKey<EasyRefreshState> _easyRefreshKey =
      new GlobalKey<EasyRefreshState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(_easyRefreshKey),
            Column(
              children: <Widget>[
                RightCategoryNav(_easyRefreshKey),
                CategoryGoodsList(_footerkey, _headerKey, _easyRefreshKey)
              ],
            )
          ],
        ),
      ),
    );
  }
}

// 左侧大类导航

class LeftCategoryNav extends StatelessWidget {
  final _easyRefreshKey;
  LeftCategoryNav(this._easyRefreshKey);
  @override
  Widget build(BuildContext context) {
    Provide.value<CategoryGoodsListProvide>(context).getCategory(context);
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, val) {
        return Container(
          width: ScreenUtil().setWidth(180),
          decoration: BoxDecoration(
              border:
                  Border(right: BorderSide(width: 0.5, color: Colors.black12))),
          child: ListView.builder(
            itemCount:
                Provide.value<CategoryGoodsListProvide>(context).list.length,
            itemBuilder: (context, index) {
              return _leftInkWell(index, context);
            },
          ),
        );
      },
    );
  }

  Widget _leftInkWell(int index, context) {
    List list = Provide.value<CategoryGoodsListProvide>(context).list;
    int currentIndex =
        Provide.value<CategoryGoodsListProvide>(context).currentIndex;
    return InkWell(
      onTap: () async {
        Provide.value<CategoryGoodsListProvide>(context).clearGoodsList();
        await Provide.value<CategoryGoodsListProvide>(context)
            .changeCurrentIndex(index);
        var childList = list[index].bxMallSubDto;
        var categoryId = list[index].mallCategoryId;
        await Provide.value<ChildCategory>(context)
            .getChildCategory(childList, categoryId);
        _easyRefreshKey.currentState.callRefresh();
        // await Provide.value<CategoryGoodsListProvide>(context)
        //     .changeGoodsList(context);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0, top: 20.0),
        decoration: BoxDecoration(
            color: (currentIndex == index)
                ? Color.fromRGBO(236, 236, 236, 1.0)
                : Colors.white,
            border:
                Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}

//小类右侧导航
class RightCategoryNav extends StatelessWidget {
  final _easyRefreshKey;
  RightCategoryNav(this._easyRefreshKey);
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570.0),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(width: 0.5, color: Colors.black12)),
              color: Colors.white),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: childCategory.childCategoryList.length,
            itemBuilder: (context, index) {
              return _rightInkWell(
                  childCategory.childCategoryList[index], index, context);
            },
          ),
        );
      },
    );
  }

  Widget _rightInkWell(BxMallSubDto item, index, context) {
    return InkWell(
      onTap: () {
        Provide.value<CategoryGoodsListProvide>(context).clearGoodsList();
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);

        _easyRefreshKey.currentState.callRefresh();
        // Provide.value<CategoryGoodsListProvide>(context)
        //     .changeGoodsList(context);
        // _easyRefreshKey.currentState.callRefresh();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: Provide.value<ChildCategory>(context).childIndex == index
                  ? Colors.pink
                  : Colors.black),
        ),
      ),
    );
  }
}

// 商品列表，可以上拉加载

class CategoryGoodsList extends StatelessWidget {
  final _footerkey;
  final _headerKey;
  final _easyRefreshKey;
  CategoryGoodsList(this._footerkey, this._headerKey, this._easyRefreshKey);
  // final GlobalKey<RefreshFooterState> _footerkey =
  //     new GlobalKey<RefreshFooterState>();

  // final GlobalKey<RefreshHeaderState> _headerKey =
  //     new GlobalKey<RefreshHeaderState>();

  // final GlobalKey<EasyRefreshState> _easyRefreshKey =
  //     new GlobalKey<EasyRefreshState>();

  final ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    Provide.value<CategoryGoodsListProvide>(context).changeGoodsList(context);
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        return Expanded(
            child: Container(
          margin: EdgeInsets.only(top: 2.0),
          width: ScreenUtil().setWidth(570),
          child: EasyRefresh(
            // emptyWidget: Text('加载中。。。'),
            key: _easyRefreshKey,
            refreshFooter: ClassicsFooter(
              bgColor: Colors.white,
              textColor: Colors.black38,
              moreInfoColor: Colors.black38,
              showMore: true,
              noMoreText: '加载完成',
              moreInfo: 'loading',
              loadReadyText: '松手加载',
              loadText: '上拉加载更多',
              loadingText: '加载中...',
              loadedText: '加载成功',
              key: _footerkey,
              loadHeight: 50.0,
            ),
            refreshHeader: ClassicsHeader(
              bgColor: Colors.white,
              key: _headerKey,
              textColor: Colors.black38,
              refreshingText: '加载中...',
              refreshText: '下拉释放刷新',
              refreshReadyText: '释放刷新',
              refreshedText: '刷新成功',
            ),
            child: ListView(
              controller: scrollController,
              children: <Widget>[_wrapList(data.goodsList, context)],
              // scrollDirection: Axis.vertical,
            ),
            loadMore: () async {
              await Provide.value<CategoryGoodsListProvide>(context)
                  .loadMoreGoodsList(context);
            },
            onRefresh: () async {
              await Provide.value<CategoryGoodsListProvide>(context)
                  .changeGoodsList(context);
            },
          ),
        ));
      },
    );
  }

  Widget _wrapList(List<MallGoodsListData> list, context) {
    if (list != null) {
      List<Widget> listWidget = list.map((val) {
        return InkWell(
          onTap: () {
            Application.router.navigateTo(context, '/detail?id=${val.goodsId}');
          },
          child: Container(
            width: ScreenUtil().setWidth(280),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  '${val.image}',
                  width: ScreenUtil().setWidth(280),
                ),
                Text(
                  '${val.goodsName}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.pink, fontSize: ScreenUtil().setSp(22)),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      '￥${val.oriPrice}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough,
                          fontSize: ScreenUtil().setSp(22)),
                    ),
                    Text(
                      '￥${val.presentPrice}',
                      style: TextStyle(fontSize: ScreenUtil().setSp(22)),
                    ),
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
      return Text(
        '该分类下暂无产品',
        textAlign: TextAlign.center,
      );
    }
  }
}
