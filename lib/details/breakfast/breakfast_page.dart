import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BreakFast extends StatefulWidget {
  const BreakFast({super.key});

  @override
  _BreakFastListPageState createState() => _BreakFastListPageState();
}

class _BreakFastListPageState extends State<BreakFast> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text('BreakFast List',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.orange[700],),
        )
      ),
      body: ListView(

        children: BreakFastitems.map((item) {
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
                SizedBox(width: 5,),
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


List<Map<String, dynamic>> BreakFastitems = [
  {
    'name': 'BreakFast1',
    "imagePath": 'assets/breakfast.jpeg',
    'price': '45 LE',
    "des":"it is 7AM "

    //add path
  },
  {'name': 'BreakFast2', "imagePath": 'assets/breakfast.jpeg', 'price': '35 LE',    "des":"it is 7AM "
  },
  {'name': 'BreakFast', "imagePath": 'assets/breakfast.jpeg', 'price': '55 LE',    "des":"it is 7AM "
  },
];
