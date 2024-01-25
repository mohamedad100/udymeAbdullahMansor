
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/layout/shop_app/cubit/cubit.dart';
import 'package:untitled/layout/shop_app/cubit/states.dart';
import 'package:untitled/models/shop_app/home_model.dart';
import 'package:untitled/shared/components/components.dart';

import '../../../models/shop_app/categories_model.dart';
import '../favorites/favorite_screen.dart';
class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {
        if(state is ShopSuccessChangeFavoritesStates){
         if(! state.model.status){
           showToast(text:state.model.message! , states:ToastStates.ERROR );
         }
        }
      },
      builder: (BuildContext context, ShopStates state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&  ShopCubit.get(context).categoriesModel != null ,
            builder: (context) =>
                productsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget productsBuilder(HomeModel? model,CategoriesModel? categoriesModel,context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),  //شكل للاسكرول
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: model?.data?.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                    height: 250,
                    initialPage: 0,
                    viewportFraction: 1.0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal)),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10
                 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text('Categories',
                  style: TextStyle(
                    fontSize: 24,
                     fontWeight: FontWeight.w800
                  ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index)=> buildCategorieItem(categoriesModel.data.data[index]),
                        separatorBuilder:(context,index)=>SizedBox(
                          width: 10,
                        ),
                        itemCount:categoriesModel!.data.data.length
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('New products',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,                           //shrinkWrap & physics عشان اعمل للاسكرينه كلها سكرول
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,                         //crossAxisCount & mainAxisSpacing item للمسافات بين
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1/1.71,                   //childAspectRatio itemحجم ال
                children: List.generate(
                    model!.data!.products.length,
                    (index) => buildGridProducts(model.data!.products[index],context ),
              ),
              ),
            ),
          ],
        ),
  );

  Widget buildCategorieItem(DataModel model)=>  Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(image: NetworkImage(model.image),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 100,
        child: Text(model.name,
          textAlign: TextAlign.center,
          overflow:TextOverflow.ellipsis ,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProducts(ProductsModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
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
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.3
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',

                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.blue
                    ),
                  ),
                  if(model.discount !=0)
                  Text(
                    '${model.oldPrice.round()}',

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
                        print(model.id);
                      },
                      icon: CircleAvatar(
                    radius: 15,
                  backgroundColor: ShopCubit.get(context).favorites[model.id]! ? Colors.blue : Colors.grey ,
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
  );

}
