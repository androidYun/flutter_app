import 'package:json_annotation/json_annotation.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
import 'dart:convert' show json;

class LoginResp {
  int code;
  String resultMessage;
  Data data;

  LoginResp.fromParams({this.code, this.resultMessage, this.data});

  factory LoginResp(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new LoginResp.fromJson(json.decode(jsonStr))
          : new LoginResp.fromJson(jsonStr);

  LoginResp.fromJson(jsonRes) {
    code = jsonRes['code'];
    resultMessage = jsonRes['resultMessage'];
    data = jsonRes['data'] == null ? null : new Data.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"code": $code,"resultMessage": ${resultMessage != null ? '${json.encode(resultMessage)}' : 'null'},"data": $data}';
  }
}

class Data {
  int merchantId;
  int refreshTokenExpiresIn;
  int tokenExpiresIn;
  String accessToken;
  String merchantName;
  String refreshToken;

  Data.fromParams(
      {this.merchantId,
      this.refreshTokenExpiresIn,
      this.tokenExpiresIn,
      this.accessToken,
      this.merchantName,
      this.refreshToken});

  Data.fromJson(jsonRes) {
    merchantId = jsonRes['merchantId'];
    refreshTokenExpiresIn = jsonRes['refreshTokenExpiresIn'];
    tokenExpiresIn = jsonRes['tokenExpiresIn'];
    accessToken = jsonRes['accessToken'];
    merchantName = jsonRes['merchantName'];
    refreshToken = jsonRes['refreshToken'];
  }

  @override
  String toString() {
    return '{"merchantId": $merchantId,"refreshTokenExpiresIn": ${refreshToken != null ? '${json.encode(refreshToken)}' : 'null'}ExpiresIn,"tokenExpiresIn": $tokenExpiresIn,"accessToken": ${accessToken != null ? '${json.encode(accessToken)}' : 'null'},"merchantName": ${merchantName != null ? '${json.encode(merchantName)}' : 'null'},"refreshToken": ${refreshToken != null ? '${json.encode(refreshToken)}' : 'null'}}';
  }
}
