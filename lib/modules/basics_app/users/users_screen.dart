import 'package:flutter/material.dart';
import 'package:untitled/models/user/user_model.dart';


class UsersScreen extends StatelessWidget {

   List<UserMdel> users = [
     UserMdel(
        id: 1,
        name: 'Mohamed',
        phone: '+01129376212'
     ),
     UserMdel(
         id: 2,
         name: 'rady',
         phone: '+010928364932'
     ),
     UserMdel(
         id: 4,
         name: 'waled',
         phone: '+01128754012'
     ),
     UserMdel(
         id: 1,
         name: 'Mohamed',
         phone: '+01129376212'
     ),
     UserMdel(
         id: 2,
         name: 'rady',
         phone: '+010928364932'
     ),
     UserMdel(
         id: 4,
         name: 'waled',
         phone: '+01128754012'
     ),
     UserMdel(
         id: 1,
         name: 'Mohamed',
         phone: '+01129376212'
     ),
     UserMdel(
         id: 2,
         name: 'rady',
         phone: '+010928364932'
     ),
     UserMdel(
         id: 4,
         name: 'waled',
         phone: '+01128754012'
     ),
     UserMdel(
         id: 1,
         name: 'Mohamed',
         phone: '+01129376212'
     ),
     UserMdel(
         id: 2,
         name: 'rady',
         phone: '+010928364932'
     ),
     UserMdel(
         id: 4,
         name: 'waled',
         phone: '+01128754012'
     ),
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('User'),
        ),
      body: ListView.separated(
          itemBuilder: (context , index) =>BuildUserItem(users[index]),
          separatorBuilder: (context , index)=> Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: users.length,)
    );
  }
  
  Widget BuildUserItem (UserMdel user) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          child: Text('${user.id}',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Text('${user.name}',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
            Text(
              '${user.phone}',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
