import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';
import './details_pages/details_top.dart';
import './details_pages/details_explain.dart';
import './details_pages/detail_tab_bar.dart';
import './details_pages/details_webview.dart';
import './details_pages/details_bottom.dart';

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
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailsTop(),
                      DetailsExplainPage(),
                      DetailsTabBar(),
                      DetailsWebview()
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottom(),
                )
              ],
            );
          } else {
            return Text('加载中...');
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
