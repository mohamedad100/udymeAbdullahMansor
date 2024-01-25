import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/modules/shop_app/login/shop_login_screen.dart';
import 'package:untitled/shared/components/components.dart';
import 'package:untitled/shared/network/local/cache_helper.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.body,
    required this.title,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> Boarding = [
    BoardingModel(
        image: 'assets/images/onBoard_1.jpg',
        body: 'on board 1 body',
        title: 'on board 1 title',
    ),
    BoardingModel(
      image: 'assets/images/onBoard_1.jpg',
      body: 'on board 2 body',
      title: 'on board 2 title',
    ),
    BoardingModel(
      image: 'assets/images/onBoard_1.jpg',
      body: 'on board 3 body',
      title: 'on board 3 title',
    )
  ];

  var boardController = PageController();
  bool isLast = false;
  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {

      navigateAndFinish(context, ShopLoginScreen());
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [

          TextButton(onPressed: submit,
              child: Text('SKIP'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller:boardController ,
                onPageChanged: (int index){
                  if(index==Boarding.length-1)
                    {
                      setState(() {
                        isLast=true;
                      });
                      print('last');
                    }else{
                    setState(() {
                      isLast=false;
                      print('not last');

                    });

                  }
                },
                itemBuilder: (context, index) => buildBoardingItem(Boarding[index]),
                itemCount: Boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    count: Boarding.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 0.5,
                    ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast)
                      {
                        submit();
                      }else{
                      boardController.nextPage(
                          duration: Duration(
                              milliseconds:720
                          ),
                          curve: Curves.fastEaseInToSlowEaseOut
                      );
                    }

                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(image: AssetImage('${model.image}')),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      );
}
