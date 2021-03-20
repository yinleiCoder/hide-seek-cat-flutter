
import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';
import 'package:flutter_hide_seek_cat/common/widgets/widgets.dart';
import 'package:flutter_hide_seek_cat/global.dart';

/**
 * Dio封装
 * dio: https://pub.dev/packages/dio
 * dio_cookie_manager: https://pub.dev/packages/dio_cookie_manager
 * cookie_jar: https://pub.dev/packages/cookie_jar
 * @author yinlei
*/
class AppHttps {
  /// singleton design mode.
  static AppHttps _instance = AppHttps._internal();
  factory AppHttps() => _instance;

  Dio dio;
  CancelToken cancelToken = new CancelToken();

  AppHttps._internal() {
    /// Base Options
    BaseOptions options = new BaseOptions(
      baseUrl: SERVER_API_URL,
      connectTimeout: 10000,
      receiveTimeout: 5000,
      headers: {},
      contentType: "application/json; charset=utf-8",
      responseType: ResponseType.json,
    );

    /// init dio.
    dio = new Dio(options);
    
    /// cookie.
    CookieJar cookieJar = CookieJar();
    /// cookie dio manager.
    dio.interceptors.add(CookieManager(cookieJar));
    // print(cookieJar.loadForRequest(Uri.parse(SERVER_API_URL)));
    // await dio.get(SERVER_API_URL);

    /// dio interceptors.
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        return options;
      },
      onResponse: (Response reponse) async {
        return reponse;
      },
      onError: (DioError e) async {
        /// 错误捕获并处理
        ErrorEntity eInfo = createErrorEntity(e);
        /// toast error msg.
        appShowToast(msg: eInfo.message);
        // extra filed:  Custom field that you can retrieve it later in [Interceptor]、[Transformer] and the   [Response] object
        var context = e.request.extra['context'];
        if(context != null) {
          switch(eInfo.code) {
            case 401: /// 我写的Koa后台程序会根据TOKEN JWT等认证来确认当前用户是否有效
              // go to login.
              // goLoginPage(context);
              break;
            default:
          }
        }
        return eInfo;
      }
    ));

    /// add network request Method: Get —— Cache.
    dio.interceptors.add(AppNetCache());

    // add network proxy. please visit:https://pub.dev/packages/dio #HttpClientAdapter
    if(!AppGlobal.isRelease && PROXY_ENABLE) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
        // config the http client
        client.findProxy = (uri) {
          //proxy all request to localhost:8888
          return "PROXY $PROXY_IP:$PROXY_PORT";
        };
        client.badCertificateCallback=(X509Certificate cert, String host, int port){
          return false;
        };
        // you can also create a new HttpClient to dio
        // return new HttpClient();
      };
    }

  }

  /// 撤销某类HTTP请求
  /**
   * CancelToken token = CancelToken();
      dio.get(url1, cancelToken: token);
      dio.get(url2, cancelToken: token);

      // cancel the requests with "cancelled" message.
      token.cancel("cancelled");
   */
  void cancelRequests(CancelToken token) {
    token.cancel('cancelled');
  }

  /// 读取本地存储的JWT Token(JWT是无状态的，我写的后端KOA2通过JWT认证成功后将用户信息挂载到koa2的全局ctx.state.user上下文中)
  Map<String, dynamic> getAuthorizationHeader() {
    var headers;
    String token = AppGlobal.profile?.token;
    if(token != null) {
      headers = {
        'Authorization': 'Bearer $token',
      };
    }
    return headers;
  }

  /// 抽取公用的GET POST PUT PATCH DELETE请求方法
  Future get(
    String path,
  {
    @required BuildContext context,
    dynamic params,
    Options options,
    bool refresh = false,
    bool noCache = !CACHE_ENABLE,
    bool list = false,
    String cacheKey,
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.merge(
      extra: {
        "context": context,
        "refresh": refresh,
        "noCache": noCache,
        "list": list,
        "cacheKey": cacheKey,
        "cacheDisk": cacheDisk,
      },
    );
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if(_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.get(
      path,
      queryParameters: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future post(
    String path,
  {
    @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.merge(
      extra: {
        "context": context,
      },
    );
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if(_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.post(
      path,
      data: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future put(
    String path,
  {
    @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.merge(
      extra: {
        "context": context,
      },
    );
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if(_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.put(
      path,
      data: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future patch(
    String path,
  {
    @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.merge(
      extra: {
        "context": context,
      },
    );
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if(_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.patch(
      path,
      data: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future delete(
    String path,
  {
    @required BuildContext context,
    dynamic params,
    Options options,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.merge(
      extra: {
        "context": context,
      },
    );
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if(_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.delete(
      path,
      data: params,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  Future postFormData(
      String path,
      {
        @required BuildContext context,
        dynamic params,
        Options options,
      }) async {
    Options requestOptions = options ?? Options();
    requestOptions = requestOptions.merge(
      extra: {
        "context": context,
      },
    );
    Map<String, dynamic> _authorization = getAuthorizationHeader();
    if(_authorization != null) {
      requestOptions = requestOptions.merge(headers: _authorization);
    }
    var response = await dio.post(
      path,
      data: FormData.fromMap(params),
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// 全局错误处理
  ErrorEntity createErrorEntity(DioError error) {
    switch(error.type) {
      case DioErrorType.CANCEL:
        {
          return ErrorEntity(code: -1, message: "请求取消");
        }
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        {
          return ErrorEntity(code: -1, message: "连接超时");
        }
        break;
      case DioErrorType.SEND_TIMEOUT:
        {
          return ErrorEntity(code: -1, message: "请求超时");
        }
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        {
          return ErrorEntity(code: -1, message: "响应超时");
        }
        break;
      case DioErrorType.RESPONSE:
        {
          try {
            int errCode = error.response.statusCode;
            // String errMsg = error.response.statusMessage;
            // return ErrorEntity(code: errCode, message: errMsg);
            switch (errCode) {
              case 400:
                {
                  return ErrorEntity(code: errCode, message: "请求语法错误");
                }
                break;
              // case 401:
              //   {
              //     return ErrorEntity(code: errCode, message: "没有权限");
              //   }
              //   break;
              case 403:
                {
                  return ErrorEntity(code: errCode, message: "服务器拒绝执行");
                }
                break;
              case 404:
                {
                  return ErrorEntity(code: errCode, message: "无法连接服务器");
                }
                break;
              case 405:
                {
                  return ErrorEntity(code: errCode, message: "请求方法被禁止");
                }
                break;
              case 500:
                {
                  return ErrorEntity(code: errCode, message: "服务器内部错误");
                }
                break;
              case 502:
                {
                  return ErrorEntity(code: errCode, message: "无效的请求");
                }
                break;
              case 503:
                {
                  return ErrorEntity(code: errCode, message: "服务器挂了");
                }
                break;
              case 505:
                {
                  return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
                }
                break;
              default:
                {
                  // return ErrorEntity(code: errCode, message: "未知错误");
                  // return ErrorEntity(
                  //     code: errCode, message: error.response.statusMessage);

                  // 此处是因为express 后端全局统一了返回格式
                  return ErrorEntity(
                      code: errCode, message: error.response.data['message']);
                }
            }
          } on Exception catch (_) {
            return ErrorEntity(code: -1, message: "未知错误");
          }
        }
        break;
      default:
        {
          return ErrorEntity(code: -1, message: error.message);
        }
    }
  }


}

/// 全局错误处理实体类
class ErrorEntity implements Exception {
  int code;
  String message;
  ErrorEntity({this.code, this.message});

  @override
  String toString() {
    return (message == null) ? "Exception" : "Exception: code $code, $message";
  }

}