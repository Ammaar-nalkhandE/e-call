
import 'package:flutter/material.dart';
import 'dialer.dart';
import 'eco_home.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home:  Scaffold(
        backgroundColor: Colors.green,

        body: const Dialer(),
         bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

          TextButton(onPressed: (){
            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EcoHome()),
                            );
          }  , child: const Text("Eco"),),
          TextButton(onPressed: (){}  , child: const Text("Contacts"),),
          TextButton(onPressed: (){}  , child: const Text("Resents"),),
          ],
        ),

        // bottomNavigationBar: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //
        //
        //           IconButton(onPressed: (){
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(builder: (context) => test()),
        //             );
        //           }, icon: Icon(Icons.co_present)),
        //           IconButton(onPressed: (){
        //
        //           }, icon: Icon(Icons.co_present)),
        //           IconButton(onPressed: (){
        //
        //           }, icon: Icon(Icons.co_present)),
        //           IconButton(onPressed: (){
        //
        //           }, icon: Icon(Icons.co_present)),
        //           IconButton(onPressed: (){
        //
        //           }, icon: Icon(Icons.co_present)),
        //
        //
        //
        //         ],
        //
        //     )

        )

    );
  }
}
