import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_app/common/CommonApi.dart';
import 'package:flutter_app/common/SpUtils.dart';

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
    var accessToken = SpUtils.instance.getAccessToken();
    options = new Options(
        baseUrl: CommonApi.baseUrl,
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "Access-Token": accessToken,
          "Platform": "Android",
          "Version": 1440,
          "Accept": "application/json"
        },
        responseType: ResponseType.JSON);
    dio = new Dio(options);
    dio.interceptor.response.onSuccess = (Response response) {
      print('响应${response.data}');
      return response; // continue
    };
  }

  void updateToken(String token) {
    options.headers.addAll({"Access-Token": token});
    dio.options = options;
  }

  void get(String url, data, Function successCallBack,
      Function errorCallBack) async {
    try {
      var response = await dio.get(url, data: data);
      print(response.data);
      if (response.data['code'] == 200) {
        successCallBack(response.data);
      } else {
        if (errorCallBack != null) {
          errorCallBack(response.data["resultMessage"]);
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

  void post(String url, data, Function successCallBack,
      Function errorCallBack) async {
    try {
      var response = await dio.post(url, data: data);
      print(response.data);
      if (response.data['code'] == 200) {
        if (successCallBack != null) {
          successCallBack(response.data);
        } else {
          errorCallBack("not implement interface");
        }
      } else {
        if (errorCallBack != null) {
          errorCallBack(response.data["resultMessage"]);
        }
      }
    } on DioError catch (e) {
      if (errorCallBack != null) {
        errorCallBack(e.message);
      }
    } catch (e) {
      if (errorCallBack != null) {
        errorCallBack('Something really unknown: $e');
      }
    }
  }
}
