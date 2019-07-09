import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';
import './details_pages/details_top.dart';
import './details_pages/details_explain.dart';
import './details_pages/detail_tab_bar.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    // _getDetailsInfo(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                children: <Widget>[
                  DetailsTop(),
                  DetailsExplainPage(),
                  DetailsTabBar()
                ],
              ),
            );
          } else {
            Text('加载中...');
          }
        },
        future: _getDetailsInfo(context),
      ),
    );
  }

  Future _getDetailsInfo(BuildContext context) async {
    await Provide.value<DetailInfoProvide>(context).getGoodsDetailInfo(goodsId);
    return 'finish loading';
  }
}
