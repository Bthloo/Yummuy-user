import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HealthFood extends StatefulWidget {
  const HealthFood({super.key});

  @override
  _HealthFoodListPageState createState() => _HealthFoodListPageState();
}

class _HealthFoodListPageState extends State<HealthFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          'Healthy Food List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.orange[700],
          ),
        ),
      ),
      body: ListView(
        children: Healthitems.map((item) {
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
                        const SizedBox(height: 2),

                      ],
                    ),
                    const SizedBox(width: 15),
                    Column(mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment:  CrossAxisAlignment.start,
                      children: [
                        Text(
                          item["name"],
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),

                        const SizedBox(height: 2,),
                        Text(
                          item["price"],
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item["des"],
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(width: 5,),
                    Column(
                      children: [ Padding(padding: const EdgeInsets.all(16),
                          child:TextButton(onPressed: (){}, child: const Icon(CupertinoIcons.shopping_cart))
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

List<Map<String, dynamic>> Healthitems = [
  {
    'name': 'Healthy1',
    "imagePath": 'assets/healthy.jpg',
    'price': '35 LE',
    "des": "keep your health "
  },
  {
    'name': 'Healthy2',
    "imagePath": 'assets/healthy.jpg',
    'price': '65 LE',
    "des": "keep your health "
  },
  {
    'name': 'Healthy3',
    "imagePath": 'assets/healthy.jpg',
    'price': '55 LE',
    "des": "keep your health "
  },
];
