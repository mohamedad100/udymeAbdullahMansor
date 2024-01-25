import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:Colors.white,
        elevation: 0.0,
        titleSpacing: 20,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage('https://rheb.cc/wp-content/uploads/2021/04/39827-1.jpg'),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              'Chats',
              style: TextStyle(
                color: Colors.black
              ),

            ),
          ],
        ),
        actions: [
          IconButton(onPressed: (){},
              icon: CircleAvatar(
                radius: 15,
                child: Icon(
                  Icons.camera_alt,
                  color:Colors.white ,
                  size:16 ,
                ),
              )),
          IconButton(onPressed: (){},
              icon: CircleAvatar(
                radius: 15,
                child: Icon(
                  Icons.edit,
                  color:Colors.white ,
                  size:16 ,
                ),
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey[300],
                ),
                padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(
                      Icons.search
                    ),
                  SizedBox(
                    width: 15.0
                  ),
                  Text(
                    'Search'
                  ),

                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 105,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                    itemBuilder:(context,index)=>  buildStoryItem(),

                  separatorBuilder: (context , index)=> SizedBox(
                    width: 20,
                  ),
                  itemCount: 5,
                ),
              ),
              SizedBox(
                height: 50,),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  itemBuilder:(context , index) => buildChatItem(),
                  separatorBuilder:(context , index ) => SizedBox(
                    height:20.0 ,
                  ),
                  itemCount: 15
              )

            ],
          ),
        ),
      ),

    );
  }
  //build item
  //arrow function

  Widget buildChatItem() => Row(
    children:[
      Stack(
        alignment:AlignmentDirectional.bottomEnd,
        children:[
          CircleAvatar(
            radius:30,
            backgroundImage:NetworkImage('https://upload.wikimedia.org/wikipedia/ar/thumb/6/65/Walter_White2.jpg/247px-Walter_White2.jpg'),
          ),
          Padding(
            padding:const EdgeInsetsDirectional.only(
              end:3,
              bottom:3,
            ),
            child:CircleAvatar(
              radius:7,
              backgroundColor:Colors.red,
            ),
          ),

        ],
      ),
      SizedBox(width:20,),
      Expanded(
        child:Column(crossAxisAlignment:CrossAxisAlignment.start,
          children:[
            Text('Ahmedtaher',
              maxLines:1,
              overflow:TextOverflow.ellipsis,
              style:TextStyle(
                fontWeight:FontWeight.bold,
                fontSize:16,
              ),
            ),
            SizedBox(
              height:5,
            ),
            Row(
              children:[
                Expanded(
                    child:Text(
                      'halomohamedhowoldareyouhowareyouu?',
                      maxLines:2,
                      overflow:TextOverflow.ellipsis,
                    )),
                Padding(
                  padding:const EdgeInsets.symmetric(
                      horizontal:10
                  ),
                  child:Container(
                    height:5,
                    width:5,
                    decoration:BoxDecoration(
                        color:Colors.blue,
                        shape:BoxShape.circle

                    ),
                  ),
                ),
                Text('10.49pm'),

              ],
            ),
          ],
        ),
      ),
    ],
  )
  ;

  Widget buildStoryItem() =>Container(
    width: 70,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/ar/thumb/6/65/Walter_White2.jpg/247px-Walter_White2.jpg'),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                end: 3,
                bottom:3 ,
              ),
              child: CircleAvatar(
                radius: 7,
                backgroundColor:Colors.red ,
              ),
            ),

          ],
        ),
        SizedBox(
          height: 6,
        ),
        Text(
          'Mohamed Adel badawe mohamed',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}
