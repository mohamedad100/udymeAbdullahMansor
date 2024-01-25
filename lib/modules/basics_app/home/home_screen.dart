

import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
                       leading:  Icon(
                                       Icons.menu ,
                       ),
                        title:Text(
                                   'First App') ,
                        actions:
                        [ 
                          
                                  
                                 IconButton(onPressed: (){
                                   print('jgchj');
                                 },
                                  icon: Icon(
                                    Icons.notification_important ,
                                  ),)
                               
                               
                          ,


                          IconButton(icon: Icon(Icons.search),
                                     onPressed: (){
                                      print('search');
                                     } )
                        ],
                          backgroundColor:Colors.teal ,
                           )  ,
       body:Column(
         children: [
           Container(
             width: 200,
             child: Padding(
               padding: const EdgeInsets.all(50.0),
               child: Container(
                 decoration:BoxDecoration(
                   borderRadius: BorderRadius.circular(20) ,

                 ) ,
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                 child: Stack(
                   alignment: Alignment.bottomCenter,
                   children: [
                     Image(
                       image: NetworkImage(
                         'https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80'

                       ),
                          width: 200,
                       height: 200,
                       fit:BoxFit.cover ,
                     ),

                  Container(color: Colors.black.withOpacity(.7),
                    width:double.infinity ,
                    padding: EdgeInsets.symmetric(
                      vertical: 10 ,
                     // horizontal: 10
                    ),
                    child: Text(
                        'First',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ), ),
                  ),
                   ],

                 ),
               ),
             ),
           ),
         ],
       )






        // SingleChildScrollView(
        //   scrollDirection: Axis.horizontal,
        //   child: Container(height: double.infinity,
        //     child: Row(
        //       mainAxisSize: MainAxisSize.max,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //
        //       children: [
        //         Text(
        //           'first',
        //           style: TextStyle(
        //             fontSize: 30
        //           ),
        //
        //         ),
        //
        //         Text(
        //           'first',
        //           style: TextStyle(
        //               fontSize: 30
        //           ),
        //
        //         ),
        //       ],
        //     ),
        //   ),
        // )




           );

  }

  


}