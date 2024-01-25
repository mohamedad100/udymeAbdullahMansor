import 'dart:math';

import 'package:flutter/material.dart';
import 'package:untitled/modules/bmi_app/bmi_result/bmi_result_screen.dart';

class BmiScreen extends StatefulWidget {

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {

  bool isMale = true;
  double height = 120;
  double weight = 40;
  int age =20;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(
          'Bmi Calculater'
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(

                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale = true;
                        });
                      } ,
                      child: Container(

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isMale ? Colors.blue : Colors.grey[400],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image:AssetImage('assets/images/png-transparent-gender-symbol-computer-icons-male-symbol-miscellaneous-gender-symbol-man.jpg'),
                              height: 80,
                              width: 80,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'MALE',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          isMale = false;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isMale? Colors.grey[400] :Colors.blue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Image(
                              image:AssetImage('assets/images/png-clipart-gender-symbol-female-woman-female-icon-gender-people-sign.png'),
                              height: 80,
                              width: 80,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'FEMALE',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[400]
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     'HEIGHT',
                     style: TextStyle(
                         fontSize: 25,
                         fontWeight: FontWeight.bold
                     ),
                   ),
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.baseline,
                     textBaseline:TextBaseline.alphabetic ,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         '${height.round()}',
                         style: TextStyle(
                             fontSize: 40,
                             fontWeight: FontWeight.w900
                         ),
                       ),
                       SizedBox(
                         width: 5,
                       ),
                       Text(
                         'CM',
                         style: TextStyle(
                             fontSize: 20,
                             fontWeight: FontWeight.bold
                         ),
                       ),
                     ],
                   ),
                   Slider(value: height,
                          max: 220,
                          min: 80,
                       onChanged:(value){
                     setState(() {
                       height = value ;
                     });

                       } ,
                   )
                     ],
                ),
              ),
            ),
          ),
          SizedBox(width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[400],
                      ),
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'WEIGHT',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '${weight}',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(onPressed: (){
                                setState(() {
                                  weight -- ;
                                });
                              },
                                heroTag: 'age--',
                                mini: true,
                              child: Icon(
                                Icons.remove
                              ),
                              ),
                              FloatingActionButton(onPressed: (){
                                setState(() {
                                  weight ++ ;
                                });
                              },
                                heroTag: 'age++',
                                mini: true,
                                child: Icon(
                                    Icons.add
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[400],
                      ),
                      child: Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AGE',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '${age}',
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FloatingActionButton(onPressed: (){
                                setState(() {
                                  age -- ;
                                });
                              },
                                heroTag: 'age-',
                                mini: true,
                                child: Icon(
                                    Icons.remove
                                ),
                              ),
                              FloatingActionButton(onPressed: (){
                                setState(() {
                                  age ++ ;
                                });
                              },
                                heroTag: 'age+',
                                mini: true,
                                child: Icon(
                                    Icons.add
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          

          Container(
            width: double.infinity,
            color: Colors.blue,
            child: MaterialButton(onPressed: (){
              var result = weight / pow(height / 100 , 2);
              print(result.round());
              Navigator.push(context,
                  MaterialPageRoute(builder:(context)=> BMIResultScreen(
                    result: result.round(),
                    age: age,
                    isMale: isMale,
                  )
              )
              );
            } ,
              height: 50,
            child:
              Text('CALCULATE',
              style: TextStyle(
                color: Colors.white,
              ),
              )
              ,),
          ),
        ],
      ),
    );
  }
}
