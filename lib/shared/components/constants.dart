
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=28463e4b146543e883b184910990c1e2


//https://newsapi.org/v2/everything?q=tesla&apiKey=28463e4b146543e883b184910990c1e2


import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';

void signOut(context){

  CacheHelper.RemoveData(key: 'token').then((value){
    navigateAndFinish(context, ShopLoginScreen());
  });
  token = null;
}

void printFullText(String text){
  final pattern= RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print (match.group(0)));
}

String? token;
String? uId;
