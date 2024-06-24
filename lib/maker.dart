import 'package:flutter/material.dart';

import 'features/profile_screen/view/pages/propag.dart';

class MakePizzaPage extends StatefulWidget {
  const MakePizzaPage({super.key});

  @override
  _MakePizzaPageState createState() => _MakePizzaPageState();
}

class _MakePizzaPageState extends State<MakePizzaPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar:BottomAppBar(
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                const SizedBox(width: 10,),
                const Text(' \$400',style: TextStyle(fontSize: 20),),
                const SizedBox(width: 40,),

                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => _buildPopupDialog(context),
                    );
                  },
                  child: const Padding(padding: EdgeInsets.symmetric(vertical: 4,horizontal: 4),
                    child: Text('Create ',style: TextStyle(fontSize: 20,color: Colors.black),),),
                ),
              ],
            ),
          ),
        ),

        appBar: AppBar(
          title: const Text(
            'Make Your Pizza',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orange),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 30, right: 20),
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    titleBar(),
                    tabs(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

Widget titleBar() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(
        width: 300, // adjust the width and height to your needs
        height: 300,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle, // make the container a circle

          color: Colors.white70, // background color of the box
        ),
        child: ClipOval(
          // clip the child to a circle
          child: Image.asset('assets/pizza.png',
              fit: BoxFit.cover), // replace with your image
        ),
      ),
      DropdownButton(padding: const EdgeInsets.all(4),
        hint: const Text("Pizza size",
          style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
        items: <String>[
          "half",
          'Small',
          'Medium',
          'Large',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (value) => (),
      ),
    ],
  );
}

Widget tabs() {
  return Container(
    height: 700,
    width: double.infinity,
    child: DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: Container(
              color: Colors.transparent,
              child: SafeArea(
                child: Column(
                  children: <Widget>[
                    TabBar(
                      isScrollable: true,
                      labelPadding: const EdgeInsets.only(top: 10),
                      indicatorColor: Colors.orange,
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                      unselectedLabelColor: Colors.black38,
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                      tabs: <Widget>[
                        Container(
                          child: const Text("Main ingredients"),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 20),
                          child: const Text("Cheese"),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 20),
                          child: const Text("Vegetables"),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: const Text("Sauce"),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: const Text("Pickle"),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 40, right: 40),
                          child: const Text("Additions"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(child: choices()),
            const Center(
              child: Text(
                "Cheese Tab",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            const Center(
              child: Text(
                "Vegetables Tab",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            const Center(
              child: Text(
                "Sauce Tab",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            const Center(
              child: Text(
                "Pickle Tab",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
            const Center(
              child: Text(
                "Additions Tab",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget choices() {
  return Column(
    children: [
      Card(
          color: ColorManager.first,
          child: Column(children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const Image(
                    image: AssetImage("assets/per.jpg"),
                    width: 60,
                    height: 100,
                    fit: BoxFit.fill),
              ),
              title: Text(
                'ingredient name',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.second,
                ),
              ),
              subtitle: Text(
                '\$100',
                style: TextStyle(
                  fontSize: 20,
                  color: ColorManager.second,
                ),
              ),
              trailing: Text(
                'X 0',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.second,
                ),
              ),
            ),
          ])),

    ],
  );
}


Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Confirmation',style: TextStyle(fontSize: 25
        ,fontWeight: FontWeight.bold),),
    content: const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            child: Text("Name it",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
        ),
        SizedBox(height: 5,),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            child: TextField()
        ),
        //price
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
            child: Text("Total Price: \$400"
              ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
        ),

        //des

      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Confirm',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
      ),
    ],
  );
}