import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrinkListPage extends StatelessWidget {
  const DrinkListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white
        ,
        title:  Text(
          'Drinks List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.orange[700],
          ),
        ),
      ),
      body: ListView(
        children: drinkitems.map((item) {
          return  Card(color: Colors.orange[400],
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            item['imagePath'],
                            height: 130,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 2),

                      ],
                    ),
                    const SizedBox(width: 15),
                    Column(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["name"],
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),

                        SizedBox(height: 2,),
                        Text(
                          item["price"],
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        SizedBox(height: 2),
                        Text(
                          item["des"],
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    ),
                    Column(
                      children: [ Padding(padding: EdgeInsets.all(16),
                          child:TextButton(onPressed: (){}, child: Icon(CupertinoIcons.shopping_cart))
                      )
                      ],
                    ),
                  ])
          );

        }).toList(),
      ),
    );
  }
}

List<Map<String, dynamic>> drinkitems = [
  {
    'name': 'Turkish Coffee',
    "imagePath": 'assets/turkishcoffe.jpg',
    'price': '25 LE',
    "des": "80mL cup os coffee",
  },
  {
    'name': 'Tea',
    "imagePath": 'assets/tea.jpeg',
    'price': '15 LE',
    "des": " coffee prepared in ",
  },
  {
    'name': 'Ice Coffee',
    "imagePath": 'assets/icedcoffe.jpg',
    'price': '70 LE',
    "des": " coffee prepared in ",
  },
  {
    'name': 'Espresso',
    "imagePath": 'assets/espresso.jpeg',
    'price': '40 LE',
    "des": " coffee prepared in ",
  },
];
