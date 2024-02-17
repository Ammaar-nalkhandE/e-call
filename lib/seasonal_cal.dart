import 'package:flutter/material.dart';



class Plant {
  final String name;
  final String imagePath;

  Plant({required this.name, required this.imagePath});
}

class SeaCal extends StatelessWidget {
  final List<String> monthImages = [
    'assets/images/jan.jpg',
    'assets/images/feb.jpg',
    'assets/images/march.jpg',
    'assets/images/april.jpg',
    'assets/images/may.jpg',
    'assets/images/june.jpg',
    'assets/images/july.jpg',
    'assets/images/aug.jpg',
    'assets/images/sept.jpg',
    'assets/images/oct.jpg',
    'assets/images/nov.jpg',
    'assets/images/dec.jpg',
  ];

  final List<String> monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'Sept', 'October', 'November', 'December'
  ];

  // Mapping of month to plants
  final Map<String, List<Plant>> plantsByMonth = {
    'January': [
      Plant(name: 'Carnations', imagePath: 'assets/images/carnation.jpg'),
      Plant(name: 'Christmas Rose', imagePath: 'assets/images/ChristmasRose.jpg'),
      Plant(name: 'Cyclamen', imagePath: 'assets/images/cyc.jpg'),
    ],
    'February': [
      Plant(name: 'Crocuses', imagePath: 'assets/images/crocus.jpg'),
      Plant(name: 'Daffodils', imagePath: 'assets/images/DaffodilFlower.jpg'),
      Plant(name: 'Snowdrops', imagePath: 'assets/images/snowdrop.jpg'),
    ],
    'March': [
      Plant(name: 'Daffodils', imagePath: 'assets/images/daffodils.jpg'),
      Plant(name: 'Tulips', imagePath: 'assets/images/tulip.jpg'),
      Plant(name: 'Hyacinths', imagePath: 'assets/images/hyacinths.jpg'),
      Plant(name: 'Primroses', imagePath: 'assets/images/Primrose.jpg'),
    ],
    'April': [
      Plant(name: 'Tulips', imagePath: 'assets/images/tuli.jpg'),
      Plant(name: 'Peonies', imagePath: 'assets/images/peonies.jpg'),
      Plant(name: 'Lilacs', imagePath: 'assets/images/lilacs.jpg'),
      Plant(name: 'Daisies', imagePath: 'assets/images/daisy.jpg'),
    ],
    'May': [
      Plant(name: 'Roses', imagePath: 'assets/images/rose.jpg'),
      Plant(name: 'Irises', imagePath: 'assets/images/ireses.jpg'),
      Plant(name: 'Lilies', imagePath: 'assets/images/Lilies.jpg'),
      Plant(name: 'Rhododendrons', imagePath: 'assets/images/Rhododendron.jpg'),
    ],
    'June': [
      Plant(name: 'Roses', imagePath: 'assets/images/Roses.jpg'),
      Plant(name: 'Hydrangeas', imagePath: 'assets/images/hyrda.jpg'),
      Plant(name: 'Gardenias', imagePath: 'assets/images/gardenias.jpg'),
      Plant(name: 'Sunflowers', imagePath: 'assets/images/sun.jpg'),
    ],
    'July': [
      Plant(name: 'Lilies', imagePath: 'assets/images/lily.jpg'),
      Plant(name: 'Water Lilies', imagePath: 'assets/images/water lily.jpg'),
      Plant(name: 'Delphiniums', imagePath: 'assets/images/delphinium.jpg'),
      Plant(name: 'Lavender', imagePath: 'assets/images/Lavender.jpg'),
    ],
    'August': [
      Plant(name: 'Dahlias', imagePath: 'assets/images/Dahlias.jpg'),
      Plant(name: 'Gladiolus', imagePath: 'assets/images/Gladiolus.jpg'),
      Plant(name: 'Hibiscus', imagePath: 'assets/images/hibiscus.jpg'),
      Plant(name: 'Zinnias', imagePath: 'assets/images/Zinnias.jpg'),
    ],
    'Sept': [
      Plant(name: 'Asters', imagePath: 'assets/images/Aster.jpg'),
      Plant(name: 'Chrysanthemums', imagePath: 'assets/images/chrysanthemum.jpg'),
      Plant(name: 'Japanese Anemones', imagePath: 'assets/images/japanese.jpg'),
      Plant(name: 'Sedum', imagePath: 'assets/images/Red Sedum.jpg'),
    ],
    'October': [
      Plant(name: 'Chrysanthemums', imagePath: 'assets/images/ChyrsanthemumsLongwood.jpg'),
      Plant(name: 'Autumn Crocus', imagePath: 'assets/images/(Autumn Crocus).jpg'),
      Plant(name: 'Nerines', imagePath: 'assets/images/nerines.jpg'),
      Plant(name: 'Dahlias', imagePath: 'assets/images/dahlia.jpg'),
    ],
    'November': [
      Plant(name: 'Chrysanthemums', imagePath: 'assets/images/ch.jpg'),
      Plant(name: 'Winter Jasmine', imagePath: 'assets/images/winter jasmne.jpg'),
      Plant(name: 'Mahonia', imagePath: 'assets/images/Mahonia.jpg'),
      Plant(name: 'Cyclamen', imagePath: 'assets/images/cy.jpg'),
    ],
    'December': [
      Plant(name: 'Holly', imagePath: 'assets/images/holly.jpg'),
      Plant(name: 'Mistletoe', imagePath: 'assets/images/mistletoe.jpg'),
      Plant(name: 'Christmas Rose', imagePath: 'assets/images/ctr.jpg'),
      Plant(name: 'Cyclamen', imagePath: 'assets/images/cyclam (1).jpg'),
    ],
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // appBar: AppBar(
        //   title: Text('Seasonal Plants Suggestion'),
        // ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/stock-phot.jpg'), // Your background image path
              fit: BoxFit.cover,
            ),
          ),
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 1, vertical: 1),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 5, // Horizontal spacing
              mainAxisSpacing: 5, // Vertical spacing
            ),
            itemCount: 12, // Total number of items
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Plants for ${monthNames[index]}'),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: plantsByMonth[monthNames[index]]!.map((plant) {
                              return Column(
                                children: [
                                  Image.asset(
                                    plant.imagePath,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    plant.name,
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 16),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
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
                },
                child: Container(
                  margin: EdgeInsets.all(8.0), // Added margin between boxes
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    image: DecorationImage(
                      image: AssetImage(monthImages[index]), // Use different image for each month
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black.withOpacity(0.5), // Add background color for contrast
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            monthNames[index],
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}