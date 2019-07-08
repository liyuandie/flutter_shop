import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/details_info.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    _getDetailsInfo(context);
    return Container(
      child: Center(
        child: Text('商品Id为：$goodsId'),
      ),
    );
  }

  void _getDetailsInfo(BuildContext context) async {
    await Provide.value<DetailInfoProvide>(context).getGoodsDetailInfo(goodsId);
    print('加载完成');
  }
}
