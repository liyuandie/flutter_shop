import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './cart_page.dart';
import './home_page.dart';
import './member_page.dart';
import './category_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心')),
  ];

  final List tabbodies = [HomePage(), CategoryPage(), CartPage(), MemberPage()];

  int currentIndex = 0;
  var currentPage;

  @override
  void initState() {
    currentPage = tabbodies[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(height: 1334, width: 750)..init(context);

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          setState(() {
            currentIndex = index;
            currentPage = tabbodies[index];
          });
        },
      ),
      body: currentPage,
    );
  }
}
