import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Burger extends StatefulWidget {
  const Burger({super.key});

  @override
  _BurgerListPageState createState() => _BurgerListPageState();
}

class _BurgerListPageState extends State<Burger> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Burger List',          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.orange[700],),
        ),
      ),
      body:
      ListView(

        children: burgeritems.map((item) {
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
     floatingActionButton:FloatingActionButton.extended(
       onPressed: () {
         // Add your onPressed code here!
       },
       label: const Text('Make yours'),
       icon: const Icon(Icons.add),
     ),



    );
  }
}

List<Map<String, dynamic>> burgeritems = [
  {
    'name': 'Burger1',
    "imagePath": 'assets/burger.jpg',
    'price':'35 Le',
    "des":"eat with happiness"
  },
  {'name': 'Burger2',
    "imagePath": 'assets/burger.jpg',
    'price':'55 LE' ,
    "des":"eat with happiness"},
  {
    'name': 'Burger3',
    "imagePath": 'assets/burger.jpg',
    'price':'45 LE',
    "des":"eat with happiness"

  },
];
