import 'package:flutter/material.dart';
import 'home_page.dart';

class EcoHome extends StatelessWidget {
  const EcoHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AppBar(
          title: Text("IN eco homepage"),
        ),

          bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.co_present)),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.co_present)),
                    IconButton(onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );

                    }, icon: Icon(Icons.dialpad),style: ButtonStyle(),),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.co_present)),
                    IconButton(onPressed: (){

                    }, icon: Icon(Icons.co_present)),



                  ],

              )

        ),

    );
  }
}
