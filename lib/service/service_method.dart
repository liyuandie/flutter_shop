import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';
import 'dart:convert';

// 获取数据通用方法
Future requestData(url, {formData}) async {
  try {
    print('开始获取数据...............');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded');
    if (formData == null) {
      response = await dio.post(servicePath[url]);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      // var _data = json.decode(response.data.toString());
      // print(_data['data']);
      return response.data;
    } else {
      throw Exception('后端接口有异常');
    }
  } catch (e) {
    return print('ERROR:........$e');
  }
}

//获取首页主题内容

Future getHomePageContent() {
  return requestData('homePageContent',
      formData: {'lon': '115.02932', 'lat': '35.76189'});
}

// 获取火爆专区内容
Future getHomePageBelowContent(formData) {
  return requestData('homePageBelowConten', formData: formData);
}

// 获取分类页面内容
Future getCategoryPageContent() {
  return requestData('getCategory');
}

// 获取分类页面内容
Future getMallGoods(formData) {
  return requestData('getMallGoods', formData: formData);
}

// 获取分类页面内容
Future getGoodsDetail(formData) {
  return requestData('getGoodDetailById', formData: formData);
}
