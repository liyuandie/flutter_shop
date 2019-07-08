import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes {
  static String root = '/';
  static String detailsPage = '/detail';

  static void configureRoute(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> param) {
      print('ERROR====>ROUTE WAS NOT FOUND!!!');
    });
    router.define(detailsPage, handler: detailHandler);
  }
}
