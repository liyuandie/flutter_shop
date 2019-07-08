import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('商品Id为：$goodsId'),
      ),
    );
  }
}
