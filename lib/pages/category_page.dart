import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'dart:convert';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Container(
      child: Center(
        child: Text('分类页面'),
      ),
    );
  }

  void _getCategory() async {
    await getCategoryPageContent().then((val) {
      var data = json.decode(val.toString());
      print(data);
    });
  }
}
