
 import 'package:flutter/material.dart';
import 'package:untitled/shared/components/components.dart';

class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
var emailcontroller = TextEditingController();

var passwordcontroller= TextEditingController();

var formKey = GlobalKey<FormState>();

bool isPassword = true;

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar:AppBar() ,
       body: Padding(
         padding: const EdgeInsets.all(20.0),
         child: Center(
           child: SingleChildScrollView(
             child: Form(
               key: formKey,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     'Login' ,
                       style: TextStyle(
                         fontSize:40 ,
                         color: Colors.black ,
                         fontWeight: FontWeight.bold

                       ),

                   ),
                   SizedBox(
                     height: 40,
                   ),

                   defultFormField(
                       controller: emailcontroller,
                       type: TextInputType.emailAddress,
                       validate: (value){
                       if(value==null || value.isEmpty) {
                         return 'email address must not be empty';
                       }
                       return null;
                       },
                       label: 'Email',
                       prefix: Icons.email,
                   ),
                   SizedBox(
                     height: 15,
                   ),
                   defultFormField(
                     controller: passwordcontroller,
                     type: TextInputType.visiblePassword,
                     validate: (value){
                       if(value==null || value.isEmpty) {
                         return 'password address must not be empty';
                       }
                       return null;
                     },
                     label: 'Password',
                     prefix: Icons.lock,
                     suffix: isPassword ? Icons.visibility: Icons.visibility_off,
                     isPassword: isPassword,
                     SuffixBressed: (){
                       setState(() {
                         isPassword=!isPassword;
                       });
                     }
                   ),
                   SizedBox(
                     height: 20,
                   ),
                   defaultButton(
                       width: double.infinity,
                       background: Colors.blue,
                       text: 'login',
                       function:(){
                         if(formKey.currentState!.validate()){
                           print(emailcontroller.text);
                           print(passwordcontroller.text);
                         }


                       }
                   ),
                   SizedBox(
                     height: 10,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                           'Don\'t have accountt?'
                       ),
                       TextButton(onPressed: (){} ,
                         child: Text(
                           'Regester Now'
                         ),)
                     ],
                   ),

                 ],
               ),
             ),
           ),
         ),
       ),
     );
   }
}
 