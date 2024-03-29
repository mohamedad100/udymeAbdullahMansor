import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

import '../../modules/shop_app/search/search_screen.dart';


class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, ShopStates state) {  },
      builder: (BuildContext context, ShopStates state) {
        var cubit = ShopCubit.get(context);
      return  Scaffold(
          appBar: AppBar(
            title: Text('Salah'),
            actions: [
              TextButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  child: Icon(Icons.search,
                  color: Colors.blue,
                  ),
              )
            ],

          ),
          body: cubit.bottomScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap:(index){
              cubit.changeBottom(index);
            } ,
              currentIndex: cubit.currentIndex,
              items:[
            BottomNavigationBarItem(
              icon: Icon(
               Icons.home,

              ),
              label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,

                ),
                label: 'Categories'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,

                ),
                label: 'Favorites'
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,

                ),
                label: 'Settings'
            ),

          ] ),

        );

      }
    );
  }
}
