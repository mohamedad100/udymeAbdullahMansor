import 'package:flutter/material.dart';
import 'package:untitled/layout/social_app/cubit/cubit.dart';
import 'package:untitled/shared/components/components.dart';

class UsersSearchDelegate extends SearchDelegate<String> {

  // These methods are mandatory you cannot skip them.

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return result(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return result(context);
  }


  result(context){
    return StreamBuilder(
      stream: SocialCubit.get(context).searchDataBase(query),
      builder: (ctx, AsyncSnapshot snapshot){
        if (!snapshot.hasData || query.isEmpty) {
          return Center(child: Text("Not Exists"));
        } else {

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (ctx2, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  title: Text(
                    snapshot.data[index].name,
                    style: Theme.of(ctx2).textTheme.bodyText1,
                  ),
                  leading: SizedBox(
                      width: 100,
                      height: 100,
                      child: Image.network(
                        snapshot.data[index].image,
                        fit: BoxFit.cover,
                      )),
                  onTap: () {
                    // navigateTo(context, UserDetailsScreen(snapshot.data[index]));
                  },
                ),
              );
            },
          );
        }
      },

    );
  }
}