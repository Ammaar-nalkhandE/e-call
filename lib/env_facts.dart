// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class EnvironmentFactsApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: EnvironmentFactsScreen(),
//     );
//   }
// }
//
// class EnvironmentFactsScreen extends StatefulWidget {
//   @override
//   _EnvironmentFactsScreenState createState() => _EnvironmentFactsScreenState();
// }
//
// class _EnvironmentFactsScreenState extends State<EnvironmentFactsScreen> {
//   String _fact = '';
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchRandomFact();
//   }
//
//   Future<void> _fetchRandomFact() async {
//     final response = await http.get(Uri.parse('https://uselessfacts.jsph.pl/random.json?language=en'));
//     if (response.statusCode == 200) {
//       final jsonData = json.decode(response.body);
//       final factText = jsonData['text'].toLowerCase(); // Convert fact text to lowercase for case-insensitive matching
//
//       // Check if the fact contains specific keywords related to nature, environment, or ecosystems
//       if (factText.contains('environment') ||
//           factText.contains('ecosystem') ||
//           factText.contains('earth') ||
//           factText.contains('climate') ||
//           factText.contains('conservation') ||
//           factText.contains('biodiversity') ||
//           factText.contains('wildlife') ||
//           factText.contains('pollution') ||
//           factText.contains('global warming') ||
//           factText.contains('sustainability')) {
//         setState(() {
//           _fact = jsonData['text'];
//         });
//       } else {
//         // If the fact does not match the filter criteria, fetch another random fact
//         _fetchRandomFact();
//       }
//     } else {
//       setState(() {
//         _fact = 'Failed to fetch random fact';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return Container(
//     //   child: Center(
//     //
//     //
//     //      child: Padding(
//     //         padding: EdgeInsets.all(5.0),
//     //         child: Column(
//     //           mainAxisAlignment: MainAxisAlignment.center,
//     //           children: [
//          return Text(
//                   _fact.isNotEmpty ? _fact : 'Loading...',
//                   textAlign: TextAlign.center,
//                 );
//                 // SizedBox(height: 20),
//                 // ElevatedButton(
//                 //   onPressed: _fetchRandomFact,
//                 //   child: Text('Next Fact'),
//                 // ),
//               // ],
//             // ),
//
//         // ),
//       // ),
//    // );
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EnvironmentFactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EnvironmentFactsScreen(),
    );
  }
}

class EnvironmentFactsScreen extends StatefulWidget {
  @override
  _EnvironmentFactsScreenState createState() => _EnvironmentFactsScreenState();
}

class _EnvironmentFactsScreenState extends State<EnvironmentFactsScreen> {
  String _fact = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchRandomFact();
    _timer = Timer.periodic(Duration(seconds: 20), (Timer timer) {
      _fetchRandomFact();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel(); // Cancel the timer to prevent memory leaks
  }

  Future<void> _fetchRandomFact() async {
    final response = await http.get(Uri.parse('https://uselessfacts.jsph.pl/random.json?language=en'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final factText = jsonData['text'].toLowerCase(); // Convert fact text to lowercase for case-insensitive matching

      // Check if the fact contains specific keywords related to nature, environment, or ecosystems
      if (factText.contains('environment') ||
          factText.contains('ecosystem') ||
          factText.contains('earth') ||
          factText.contains('climate') ||
          factText.contains('conservation') ||
          factText.contains('biodiversity') ||
          factText.contains('wildlife') ||
          factText.contains('pollution') ||
          factText.contains('global warming') ||
          factText.contains('sustainability')) {
        setState(() {
          _fact = jsonData['text'];
        });
      } else {
        // If the fact does not match the filter criteria, fetch another random fact
        _fetchRandomFact();
      }
    } else {
      setState(() {
        _fact = 'Failed to fetch random fact';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _fact.isNotEmpty ? _fact : 'Loading...',
        textAlign: TextAlign.center,
      ),
    );
  }
}
