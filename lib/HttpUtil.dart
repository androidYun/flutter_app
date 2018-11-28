import 'package:flutter_app/common/CommonApi.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class HttpUtil {
  Dio dio;

  Options options;

  static HttpUtil httpUtil;

  static HttpUtil getInstance() {
    if (httpUtil == null) {
      httpUtil = new HttpUtil();
    }
    return httpUtil;
  }

  HttpUtil() {
    options = new Options(
        baseUrl: CommonApi.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {"token": ""},
        responseType: ResponseType.JSON);
    dio = new Dio(options);
  }

  void get(String url, data, Function successCallBack,
      Function errorCallBack) async {
    try {
      var response = await dio.get(url, data: data);
      print(response.data);
      if (response.data.code == 200) {
        successCallBack(response.data);
      } else {
        if (errorCallBack != null) {
          errorCallBack(response.data["errorMessage"]);
        }
      }
    } on DioError catch (e) {
      if (errorCallBack != null) {
        errorCallBack(e.message);
      }
    } catch (e) {
      if (errorCallBack != null) {
        errorCallBack(e.message);
      }
    }
  }
}
