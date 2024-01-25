//https://www.nytimes.com/2023/12/05/us/politics/tommy-tuberville-military-promotions.html
import 'package:dio/dio.dart';

class DioHelber{

  static Dio? dio;

  static init(){
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        // headers: {
        //   'Content-Type':'application/json'
        // }
      )

    );

  }
  static Future<Response<dynamic>?> getData({
    required String url,
     Map<String,dynamic>? query,
    String lang = 'en' ,
    String? token,
  })async
  {
    dio?.options.headers={
      'lang' : lang,
      'Content-Type':'application/json',
      'Authorization':token??'',
    };

    return await dio?.get( url , queryParameters:query );
  }

  static Future<Response<dynamic>?> postData({
    required String url,
     Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String lang = 'en' ,
    String? token,
})async
  {
    dio?.options.headers={
      'lang' : lang,
      'Content-Type':'application/json',
      'Authorization':token??'',
    };

    return dio?.post(
      url,
      queryParameters: query,
      data:data
    );
  }

  static Future<Response<dynamic>?> putData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic> data,
    String lang = 'en' ,
    String? token,
  })async
  {
    dio?.options.headers={
      'lang' : lang,
      'Content-Type':'application/json',
      'Authorization':token??'',
    };

    return dio?.put(
        url,
        queryParameters: query,
        data:data
    );
  }

}

//https://student.valuxapps.com/api/

//https://www.getpostman.com/collections/3223d639447a8524e38f

//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=28463e4b146543e883b184910990c1e2

 //base url=https://newsapi.org/

// method (url)=v2/top-headlines

//query=country=eg&category=business&apiKey=28463e4b146543e883b184910990c1e2

 //https://newsapi.org/v2/top-headlines?country=eg&apiKey=aa3597b077e44e6d95d63ce2458543da

//base url=https://newsapi.org/

// method (url)=v2/top-headlines

//query=country=eg&apiKey=aa3597b077e44e6d95d63ce2458543da

