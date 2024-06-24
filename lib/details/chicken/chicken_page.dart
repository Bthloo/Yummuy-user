import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chicken extends StatefulWidget {
  const Chicken({super.key});

  @override
  _ChickenListPageState createState() => _ChickenListPageState();
}

class _ChickenListPageState extends State<Chicken> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(
            'Chicken List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.orange[700],
            ),
          ),
        ),
        body: ListView(
          children: Chickenitems.map((item) {
            return Card(
                color: Colors.orange[400],
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["name"],
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          SizedBox(
                            height: 2,
                          ),
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
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(16),
                              child: TextButton(
                                  onPressed: () {},
                                  child: Icon(CupertinoIcons.shopping_cart)))
                        ],
                      ),
                    ]));
          }).toList(),
        ));
  }
}

List<Map<String, dynamic>> Chickenitems = [
  {
    'name': 'chicken',
    "imagePath": 'assets/chicken.jpeg',
    'price': '25 LE',
    "des": "eat what you love"
  },
  {
    'name': 'chicken',
    "imagePath": 'assets/chicken.jpeg',
    'price': '35 LE',
    "des": "eat what you love"
  },
  {
    'name': 'chicken',
    "imagePath": 'assets/chicken.jpeg',
    'price': '45 LE',
    "des": "eat what you love"
  },
];
