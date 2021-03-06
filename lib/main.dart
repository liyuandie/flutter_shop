import 'package:flutter/material.dart';
import 'package:flutter_shop/model/details_madel.dart';
import 'package:flutter_shop/pages/index_page.dart';
import './provide/childCategory.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
import './provide/cart.dart';
import './provide/homePage.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';
import './route/index.dart';
import './route/application.dart';
import './provide/router.dart';

void main() {
  var childCategory = ChildCategory();
  var categoryGoodsList = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailInfoProvide();
  var cartProvide = CartProvide();
  var routerProvide = RouterProvide();
  var homePageProvide = HomePageContentProvide();
  var providers = Providers();

  providers..provide(Provider<ChildCategory>.value(childCategory));
  providers
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList));
  providers..provide(Provider<DetailInfoProvide>.value(detailsInfoProvide));
  providers..provide(Provider<CartProvide>.value(cartProvide));
  providers..provide(Provider<RouterProvide>.value(routerProvide));
  providers..provide(Provider<HomePageContentProvide>.value(homePageProvide));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = Router();
    Routes.configureRoute(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
