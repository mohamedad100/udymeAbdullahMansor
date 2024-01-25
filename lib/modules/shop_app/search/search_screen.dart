
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/modules/shop_app/search/cubit/cubit.dart';
import 'package:untitled/modules/shop_app/search/cubit/states.dart';
import 'package:untitled/shared/components/components.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../models/shop_app/favorites_model.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (BuildContext context, SearchStates state) {  },
        builder: (BuildContext context, SearchStates state) {
          return Scaffold(
            appBar: AppBar(),

            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                   defultFormField(
                       controller: searchController,
                       type: TextInputType.text,
                       validate: (String? value) {
                         if (value == null || value.isEmpty) {
                           return 'password is too short';
                         }
                       },
                       label: 'Search',
                       prefix: Icons.search,
                       onSubmit: (String text){
                         SearchCubit.get(context).search(text);
                       }

                   ),
                    SizedBox(
                      height: 10,
                    ),

                    if(state is SearchLoadingStates)
                    LinearProgressIndicator(),
                    if(SearchCubit.get(context).searchModel !=null)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context,index) => buildFavItem(SearchCubit.get(context).searchModel!.data.data[index] ,context ) ,
                          separatorBuilder:(context,index) => myDivider(),
                          itemCount: SearchCubit.get(context).searchModel!.data.data.length
                      ),
                    ),
                  ],
                ),
              ),
            )
          );
        },

      ),
    );
  }

}
