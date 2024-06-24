import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ummuy2/details/breakfast/breakfast_page.dart';
import 'package:ummuy2/details/burger/burger_page.dart';
import 'package:ummuy2/details/drinks/drinks_page.dart';
import 'package:ummuy2/details/healthyfood/healthyfood_page.dart';
import 'package:ummuy2/details/meals/meal_page.dart';
import 'package:ummuy2/details/chicken/chicken_page.dart';


class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Text('Menu',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color: Colors.orange[700]),
      ),
      ),
      body: GridView.count(
        
        crossAxisCount: 2,
        children: menuItems.map((item) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => item["path"]),
              );
            },
            child: Card(margin: const EdgeInsets.all(5),
              color: Colors.orange[400],
              child: Column(

                children: [const SizedBox(height: 10,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item['image'],
                      height: 130,width: 170,fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(children: [
                    Text(item["title"],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.white),),


                  ],)


                ],
              ),
            ),
          );
        }).toList(),

      ),
    );
  }
}

final List<Map<String, dynamic>> menuItems = [
  {'title': 'BreakFast', 'image': 'assets/breakfast.jpeg',"path": const BreakFast()},
  {'title': 'Pizza', 'image': 'assets/meal.jpg',"path": const Meal()},
  {'title': 'Healthy food', 'image': 'assets/healthy.jpg',"path": const HealthFood()},
  {'title': 'Burgers', 'image': 'assets/burger.jpg',"path": const Burger()},
  {'title': 'Dessert', 'image': 'assets/chicken.jpeg',"path": const Chicken()},
  {'title': 'Drinks', 'image': 'assets/drinks.jpg',"path": const DrinkListPage()},
];
