
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';

import '../../../models/shop_app/favorites_model.dart';

import '../../../shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (BuildContext context, ShopStates state) {  },
      builder: (BuildContext context, ShopStates state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesStates,
          builder: (context)=>ListView.separated(
              itemBuilder: (context,index) => buildFavItem(ShopCubit.get(context).favoritesModel!.data.data[index].product!  ,context ) ,
              separatorBuilder:(context,index) => myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data.data.length
          ),
          fallback: (context)=> CircularProgressIndicator(),

        );
      },
    );
  }

  Widget buildFavItem(Product model,context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image!),
                width: 120,
                height: 120,
              ),
              if(model.discount !=0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text('Discount',
                    style: TextStyle(
                        fontSize: 8,
                        color: Colors.white
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      height: 1.3
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),

                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue
                      ),
                    ),
                    if(model.discount !=0)
                      Text(
                        model.oldPrice.toString(),

                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed:(){
                            ShopCubit.get(context).changeFavorites(model.id);
                          // print(model.id);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:ShopCubit.get(context).favorites[model.id]! ? Colors.blue : Colors.grey ,

                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 25,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
