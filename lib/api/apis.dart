import 'dart:async';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';


part 'apis.g.dart';

@RestApi()
abstract class XqApi {
  factory XqApi(Dio dio, {String? baseUrl}) = _XqApi;

  @GET('/')
  Future ping();

  @GET('/u/{uid}')
  Future userInfo(@Path() dynamic uid);

  @GET('/v4/statuses/user_timeline.json')
  Future userTimeline(@Query('user_id') int uid, @Query('page') int pageId);

  @GET('/query/v1/search/user.json')
  Future searchUser(@Query('q') int q, @Query('count') int count);
}

class XqService {
  static final XqService _singleton = new XqService._internal();

  factory XqService() {
    return _singleton;
  }

  late XqApi api;
  // Dio? dio;

  XqService._internal() {
    var dio = Dio();
    var cookieJar=CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));
    // Print cookies
    // print(cookieJar.loadForRequest(Uri.parse("https://baidu.com/"))
    api = XqApi(dio, baseUrl: 'https://xueqiu.com');
  }
}