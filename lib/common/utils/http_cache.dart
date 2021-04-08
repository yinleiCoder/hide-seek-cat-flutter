import 'dart:collection';

/**
 * 针对http GET请求的缓存
 * @author yinlei
 * 1. if refresh field: delete previous cache
 * 2. if list field: delete all cache which url include current path
 * 3. noCache: switch enable cache.
*/

import 'package:dio/dio.dart';
import 'package:flutter_hide_seek_cat/common/utils/utils.dart';
import 'package:flutter_hide_seek_cat/common/values/values.dart';

/// 缓存的内容
class CacheObject {
  int timeStamp;
  Response response;
  CacheObject(this.response) : timeStamp = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(Object other) {
    return response.hashCode == other.hashCode;
  }

  @override
  int get hashCode => response.realUri.hashCode;
}

/// 自定义拦截器拦截APP请求从缓存中读取
class AppNetCache extends Interceptor {

  var cache = LinkedHashMap<String, CacheObject>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if(!CACHE_ENABLE) {
      return super.onRequest(options, handler);
    }
    bool refresh = options.extra["refresh"] == true;
    bool cacheDisk = options.extra["cacheDisk"] == true;
    if(refresh) {
      if (options.extra["list"] == true) {
        cache.removeWhere((key, v) => key.contains(options.path));
      }else {
        cache.remove(options.uri.toString());
      }
      if (cacheDisk) {
        await AppStorage().remove(options.uri.toString());
      }
      return super.onRequest(options, handler);
    }
    // get 请求，开启缓存
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == 'get') {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      // 策略 1 内存缓存优先，2 然后才是磁盘缓存
      // 1 内存缓存
      var ob = cache[key];
      if (ob != null) {
        //若缓存未过期，则返回缓存内容
        if ((DateTime.now().millisecondsSinceEpoch - ob.timeStamp) / 1000 <
            CACHE_MAXAGE) {
          return handler.resolve(cache[key].response);
        } else {
          //若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }
      // 2 磁盘缓存
      if (cacheDisk) {
        var cacheData = AppStorage().getJSON(key);
        if (cacheData != null) {
          return handler.resolve(Response(
            statusCode: 200,
            data: cacheData,
            requestOptions: options,
          ));
        }
      }
    }
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    if(CACHE_ENABLE) {
      await _saveCache(response);
    }
    super.onResponse(response, handler);
  }

  /// 编写算法缓存数据
  Future<void> _saveCache(Response object) async {
    RequestOptions options = object.requestOptions;

    // 只缓存 get 的请求
    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      // 策略：内存、磁盘都写缓存

      // 缓存key
      String key = options.extra["cacheKey"] ?? options.uri.toString();

      // 磁盘缓存
      if (options.extra["cacheDisk"] == true) {
        await AppStorage().setJSON(key, object.data);
      }

      // 内存缓存
      // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if (cache.length == CACHE_MAXCOUNT) {
        cache.remove(cache[cache.keys.first]);
      }

      cache[key] = CacheObject(object);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return super.onError(err, handler);
  }

}