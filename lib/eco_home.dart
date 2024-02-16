
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'c_footprints.dart';


class EcoHome extends StatelessWidget {
   EcoHome({super.key});
    final double iconsize = 50;
    final double iconsize_H = 80;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: AppBar(
          title: const Text("IN eco homepage"),
        ),

          bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                    SizedBox(
                      width: iconsize,
                      height: iconsize_H ,
                      child: IconButton(onPressed: (){

                      }, icon: Image.asset('assets/images/community.png')),
                    ),
                    SizedBox(
                      width: iconsize,
                      height: iconsize_H ,
                      child: IconButton(onPressed: (){

                      }, icon: Image.asset("assets/images/home.png")),
                    ),
                    SizedBox(
                      width: iconsize,
                      height: iconsize_H ,
                      child: IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );

                      }, icon: Image.asset('assets/images/call.png'),),
                    ),
                    SizedBox(
                      width: iconsize,
                      height: iconsize_H ,
                      child: IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  const CFootPrints()),
                        );

                      }, icon: Image.asset('assets/images/footprint.png')),
                    ),
                    SizedBox(
                      width: iconsize,
                      height: iconsize_H ,
                      child: IconButton(onPressed: (){

                      }, icon: Image.asset('assets/images/book1.png')),
                    ),

//THE ABOVE BUTTONS ARE NOT DISPLAYED CORRECTLY

                  ],

              )

        ),

    );
  }
}
