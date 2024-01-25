import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/shared/cubit/cubit.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../models/shop_app/favorites_model.dart';
Widget defaultButtonIcon11({
  double width = double.infinity,
  Color background = Colors.blue,
  required void Function() function,
  required IconData ICON,
}) =>
    Container(
      height: 40,
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function,
        // child: Text(
        //   isUpperCase ? text.toUpperCase() : text,
        //   style: TextStyle(color: Colors.white),
        // ),
        child: Icon(ICON),
      ),
    );


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  required void Function() function,
  required String text,
}) =>
    Container(
      height: 40,
      width: width,
      color: background,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

Widget defaultTextButton(
        {required Function() function, required String text}) =>
    TextButton(
      onPressed: function,
      child: Text(text),
    );

Widget defultFormField({
  required TextEditingController controller,
  required TextInputType type,
  void Function(String)? onSubmit,
  void Function(String)? onChange,
  required String? Function(String? string)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  void Function()? SuffixBressed,
  void Function()? onTap,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      enabled: isClickable,
      onChanged: onChange,
      validator: validate,
      obscureText: isPassword,
      onTap: onTap,
      decoration: InputDecoration(
        //hintText: 'Email Address' ,
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        suffixIcon: suffix != null
            ? MaterialButton(
                onPressed: SuffixBressed,
                child: Icon(Icons.remove_red_eye),
              )
            : null,
        // suffixIcon: Icon(
        //   Icons.email
        // ),
      ),
    );

Widget buildTaskItem(Map model, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${model['time']}'),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['date']}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context).updateData(states: 'done', id: model['id']);
            },
            icon: Icon(
              Icons.check_box,
              color: Colors.green,
            ),
          ),
          IconButton(
            onPressed: () {
              AppCubit.get(context)
                  .updateData(states: 'archive', id: model['id']);
            },
            icon: Icon(
              Icons.archive_outlined,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );

Widget myDivider() => Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[300],
    );

Widget buildArticleItem(article, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

Widget articlebuilder(list, context) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(), // no light in scroll
        itemBuilder: (BuildContext context, int index) =>
            buildArticleItem(list[index], context),
        separatorBuilder: (BuildContext context, int index) => myDivider(),
        itemCount: 20,
      ),
      fallback: (context) => Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget),
        (Route<dynamic> route) {
      return false;
    });

void showToast({
  required String text,
  required ToastStates states,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(states),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates {
  SUCCESS,
  ERROR,
  WARNING,
}

Color? chooseToastColor(ToastStates states) {
  Color? color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget buildFavItem(model, context) {
  print(ShopCubit.get(context).favorites[model.id]);
  return Padding(
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
              if (model.discount != 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  color: Colors.red,
                  child: Text(
                    'Discount',
                    style: TextStyle(fontSize: 8, color: Colors.white),
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
                  style: TextStyle(fontSize: 14, height: 1.3),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                    if (model.discount != 0)
                      Text(
                        model.oldPrice.toString(),
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                          // print(model.id);
                          print(model.id);
                        },
                        icon: CircleAvatar(
                          radius: 15,
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id] == null
                                  ? Colors.grey
                                  : ShopCubit.get(context).favorites[model.id]!
                                      ? Colors.blue
                                      : Colors.grey,
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

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? action,
})=> AppBar(
  leading: IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(Icons.arrow_back_ios),
  ),
  titleSpacing: 5,
  title: Text(title!),
  actions: action,
);
