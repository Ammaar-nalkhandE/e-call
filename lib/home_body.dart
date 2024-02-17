import 'package:final_app/Barcode.dart';
import 'package:final_app/seasonal_cal.dart';
import 'package:final_app/temp_loc.dart';
import 'package:flutter/material.dart';
import 'env_facts.dart';
import 'env_news.dart';
import 'o2_calc.dart';
import 'quiz.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String displayedInfo = '';

  void displayInfo(String info) {
    setState(() {
      displayedInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Set app bar background color to transparent
        elevation: 0, // Remove app bar elevation
        title: Text(
          'HOME PAGE',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            // Make app bar text bold
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade700, Colors.teal], // Your gradient colors
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 35,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 330,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: temp_loc(),
                    // Text(
                    //   'Temperature ',
                    //   style: TextStyle(fontSize: 16, color: Colors.white),
                    // ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 240,
              child: Container(

                height: 80,
                width: 50,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(0),
                ),
                 child: EnvironmentFactsApp(),
                // Text(
                //   '                        Fun Fact',
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),

              ),
            ),
            Positioned(
              left: 20,
              bottom: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: IconButton(onPressed:(){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('News'),
                            content: QuizScreen(), // Display EnvNews widget in the dialog
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    } , icon: Image(image: AssetImage("assets/gifs/quiz.gif"))),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '              Quiz',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child:  IconButton(onPressed: (){}, icon: Image(image: AssetImage("assets/gifs/time.gif"))),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '      Coming Soon',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              bottom: 335,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child:IconButton(onPressed:(){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('News'),
                            content: SeaCal(), // Display EnvNews widget in the dialog
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },icon: Image(image: AssetImage("assets/gifs/cal.gif"))),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '  Seasonal Calendar',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 335,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child:  IconButton(onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('News'),
                            content: BarcodeScannerPage(), // Display EnvNews widget in the dialog
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },icon: Image(image: AssetImage("assets/gifs/scan.gif"))),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '   Barcode Scanner',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: IconButton(onPressed:(){
                      showDialog(

                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(


                            title: Text('Oxygen'),
                            content: OxygenCalc(), // Display EnvNews widget in the dialog
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },icon: Image(image: AssetImage("assets/gifs/leaf.gif"))),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '    Oxygen Calculator',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              bottom: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 140,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child:  IconButton(onPressed:(){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('News'),
                            content: NewsScreen(), // Display EnvNews widget in the dialog
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },icon: Image(image: AssetImage("assets/gifs/news.gif"))),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '              News',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}