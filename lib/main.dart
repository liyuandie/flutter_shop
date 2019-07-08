import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index_page.dart';
import './provide/childCategory.dart';
import './provide/category_goods_list.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';
import './route/index.dart';
import './route/application.dart';

void main() {
  var childCategory = ChildCategory();
  var categoryGoodsList = CategoryGoodsListProvide();
  var providers = Providers();

  providers..provide(Provider<ChildCategory>.value(childCategory));
  providers
    ..provide(Provider<CategoryGoodsListProvide>.value(categoryGoodsList));
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
