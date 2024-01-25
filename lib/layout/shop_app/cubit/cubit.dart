import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/shop_app/favorites_model.dart';
import 'package:untitled/models/shop_app/home_model.dart';
import 'package:untitled/models/shop_app/login_model.dart';
import 'package:untitled/modules/shop_app/categories/categories_screen.dart';
import 'package:untitled/modules/shop_app/favorites/favorite_screen.dart';
import 'package:untitled/modules/shop_app/products/products_screen.dart';
import 'package:untitled/modules/shop_app/settings/settings_screen.dart';
import 'package:untitled/shared/network/end_points.dart';
import 'package:untitled/shared/network/remote/dio_helper.dart';

import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/profile_model.dart';
import '../../../shared/components/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;
  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  Map <int,bool> favorites={};
  ChangeFavoritesModel? changeFavoritesModel;

  List<Widget> bottomScreen=[
   ProductsScreen(),
   CategoriesScreen(),
   FavoritesScreen(),
   SettingsScreen()
  ];

  void changeBottom(int index){
    currentIndex=index;
    emit(ShopChangeBottomNavStates());
  }

  void getHomeData()
  {
    emit(ShopLoadingHomeDataStates());
    DioHelber.getData(
        url: Home,
        token: token
    ).then((value){
      homeModel = HomeModel.fromJson(value?.data);

      homeModel?.data?.products.forEach((element) {
        favorites.addAll({
          element.id : element.inFavorites
        });
      });

      print(favorites.toString());

      printFullText(homeModel.toString());       //printFullText دي ميثود عملها بتطبع كل الداتا
      print(homeModel?.data);
      print(homeModel?.statue);


      emit(ShopSuccessHomeDataStates());

    }).catchError((error){
      emit(ShopErrorHomeDataStates());
      print(error.toString());
    });

  }

  void getCategorieData()
  {
    DioHelber.getData(
        url: GET_CATEGORIES,
    ).then((value){
      categoriesModel = CategoriesModel.fromJson(value?.data);

      printFullText(categoriesModel.toString());       //printFullText دي ميثود عملها بتطبع كل الداتا



      emit(ShopSuccessCategoriesStates());

    }).catchError((error){
      emit(ShopErrorCategoriesStates());
      print(error.toString());
    });

  }

  void changeFavorites(int productId){
    favorites[productId] = !favorites[productId]!; // هنا انا بقوله لما ادوس عليك اقلب القيمه بتاعته بلعكس ترو او فولس عشان الون يتغير فوقتها
    emit(ShopChangeFavoritesStates());

    print('rooooooooooooooh');
    print(token);
    DioHelber.postData(
       url: Favorites,
       data: {
         'product_id' : productId
       },
       token: token ,
   ).then((value) {
     changeFavoritesModel= ChangeFavoritesModel.fromJson(value?.data);
     print(value?.data);
     print('tmaaaaaaaaam');

    if(!changeFavoritesModel!.status){
      favorites[productId] = !favorites[productId]!;
         //و هنا بقوله لو حصل اي ايرور و متحطش في الفيفوريت رجعها تاني زي مكانت
    }else{
      getFavorites();
    }

     emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel!));
   }).catchError((error){

      favorites[productId] = !favorites[productId]!;

      emit(ShopErrorChangeFavoritesStates());
     print(error.toString());
     print('msh tmaaaaaaaaam');

   });
  }
  //ShopCubit.get(context).favorites[model.id] ? Colors.blue : Colors.grey

    FavoritesModel? favoritesModel;

  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesStates());
    DioHelber.getData(
      url: Favorites,
      token: token
    ).then((value){
      favoritesModel = FavoritesModel.fromJson(value?.data);

  //    printFullText(value!.data.toString());       //printFullText دي ميثود عملها بتطبع كل الداتا



      emit(ShopSuccessGetFavoritesStates());

    }).catchError((error){
      emit(ShopErrorGetFavoritesStates());
      print(error.toString());
    });

  }


  pofileModel? userModel;

  void getUserModel()
  {
    emit(ShopLoadingUserDataStates());
    DioHelber.getData(
        url: PROFILE,
        token: token
    ).then((value){
      userModel = pofileModel.fromJson(value?.data);

       printFullText(userModel!.data!.name!);       //printFullText دي ميثود عملها بتطبع كل الداتا

      print('hahahahahahahahah');


      emit(ShopSuccessUserDataStates(userModel!));

    }).catchError((error){
      print('noooooooooooooooooooooooo');
      printFullText(error.toString());
      emit(ShopErrorUserDataStates());
      print(error.toString());
    });

  }

  void updateUserModel({
    required String name,
    required String email,
    required String phone
})
  {
    emit(ShopLoadingUpdateUserStates());
    DioHelber.putData(
        url: updatePROFILE,
        token: token,
        data: {
         'name':name,
         'email':email,
         'phone':phone,

        }
    ).then((value){
      userModel = pofileModel.fromJson(value?.data);

      printFullText(userModel!.data!.name!);       //printFullText دي ميثود عملها بتطبع كل الداتا

      print('hahahahahahahahah');


      emit(ShopSuccessUpdateUserStates(userModel!));

    }).catchError((error){
      print('noooooooooooooooooooooooo');
      printFullText(error.toString());
      emit(ShopErrorUpdateUserStates());
      print(error.toString());
    });

  }


}