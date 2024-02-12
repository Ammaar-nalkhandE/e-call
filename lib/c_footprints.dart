import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart'; // Import CircularPercentIndicator



class CFootPrints extends StatefulWidget {
  const CFootPrints({super.key});

  @override
  _CFootPrintsState createState() => _CFootPrintsState();
}

class _CFootPrintsState extends State<CFootPrints> {
  int selectedIndex = -1; // Track the index of the selected box
  String inputText = '';
  double sliderValue2 = 0;
  double totalPoints = 0; // Total points calculated for emissions
  double monthlyLimit = 100; // Default monthly CO2 emissions limit

  List<BoxModel> boxes = [
    BoxModel("Car", 2.296),
    BoxModel("MotorBike", 2.296),
    BoxModel("Cycle", 0.596),
    BoxModel("Train", 2.296),
    BoxModel("Bus", 2.296),
    BoxModel("Walk", 0.296),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,



      appBar: AppBar(
        title: const Text("Carbon Footprint"),

        backgroundColor: const Color(0xFFB9F6CA), // Set the app bar color

      ),
      body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF69F0AE), Colors.amber],
            ),
          ),
         // child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.directions_car, color: Colors.amberAccent, size: 40),
                      const SizedBox(width: 10),
                      Text(
                        "Transportation Options",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: boxes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            width: 150,
                            decoration: BoxDecoration(
                              color: selectedIndex == index ? Colors.blueAccent : Colors.transparent,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.schedule_outlined, color: Colors.amberAccent),
                                Text(
                                  boxes[index].name,
                                  style: const TextStyle(color: Color(0xFF66BB6A)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const Text(
                  "Scroll to the right ->",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                ),

                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Set the color of the container to white
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Enter your data for ${selectedIndex != -1 ? boxes[selectedIndex].name : 'Transportation'}:",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,color:Colors.deepPurple[900]
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              inputText = value;
                            });
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Distance in KM',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Text('Mileage: '),
                            Slider(
                              value: sliderValue2,
                              onChanged: (newValue) {
                                setState(() {
                                  sliderValue2 = newValue;
                                });
                              },
                              min: 0,
                              max: 100,
                              divisions: 100,
                              label: sliderValue2.toStringAsFixed(2),
                              activeColor: const Color(0xFF66BB6A), // Set the active color of the slider
                              inactiveColor: Colors.grey, // Set the inactive color of the slider
                              thumbColor: Colors.lightBlue, // Set the thumb color of the slider
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    if (selectedIndex != -1) {
                      // Parse the distance entered in the text box
                      int distance = int.tryParse(inputText) ?? 0;

                      // Calculate the emission points based on the distance and slider value
                      double mileage = sliderValue2;
                      totalPoints = (distance / mileage) * boxes[selectedIndex].points;

                      // Update the UI
                      setState(() {});

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.green, backgroundColor: Colors.tealAccent, // Change the font color of the button
                  ),
                  child: const Text('Calculate'),
                ),

                const SizedBox(height: 12),
                // Circular CO2 Indicator
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularPercentIndicator(
                      radius: 100.0,
                      lineWidth: 10.0,
                      percent: totalPoints / monthlyLimit, // Calculate percentage based on total points and monthly limit
                      center: Text(
                        '$totalPoints Kg', // Display total CO2 emissions
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800,color: Colors.green[900]),
                      ),
                      progressColor: Colors.indigo[800], // Change color based on percentage
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                      animationDuration: 2000,
                    ),
                    Positioned(
                      top: 120,
                      child: Text(
                        'CO2',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                          color: Colors.indigo[800],
                        ),
                      ),
                    ),

                  ],
                ),
                // const SizedBox(height: 50), // Increase the height as needed
                // const Text(
                //   'Your Daily Average',
                //   style: TextStyle(fontSize: 16.0, color: Colors.amber),
                // ),

              ],
            ),
        //  ),
        ),

    );
  }
}

class BoxModel {
  String name;
  double points;

  BoxModel(this.name, this.points);
}