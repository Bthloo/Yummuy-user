import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ummuy2/core/data_base/models/meal_model.dart';
import 'package:ummuy2/core/general_components/ColorHelper.dart';
import 'package:ummuy2/features/home_screen/viewmodel/get_category/get_categories_cubit.dart';
import 'package:ummuy2/features/home_screen/viewmodel/get_meals/get_meals_cubit.dart';
import 'package:ummuy2/features/profile_screen/view/pages/propag.dart';
import '../../../cart_screen/view/pages/cart.dart';
import '../../../det.dart';
import '../../../maker/view/pages/pizza_maker.dart';

class PizzaHome extends StatelessWidget {
  const PizzaHome({super.key});
  static const String routeName = "pizza_home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("YUMMY",style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w900
        ),),
      ),
      body: const MainApp(),
      bottomNavigationBar: const BottomBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: ExpandableFab(
      //   distance: 112,
      //   children: [
      //     ActionButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.local_pizza_outlined),
      //     ),
      //     ActionButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.local_pizza_outlined),
      //
      //       // ImageIcon(
      //       //   AssetImage('assets/burger_icon.png'),
      //       // ),
      //     ),
      //     ActionButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.local_pizza_outlined),
      //       // ImageIcon(
      //       //   AssetImage('assets/pizza_icon.png'),
      //       // ),
      //     ),
      //   ],
      // ),
    );
  }
}

GetMealsCubit getMealsCubit = GetMealsCubit();
int tabIndex = 0;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              titleBar(context),
              tabs(),
            ],
          )
        ],
      ),
    );
  }
}

Widget titleBar(BuildContext context) {
  return  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            "MENU",
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 40),
          ),
          Text(".......", style: TextStyle(fontSize: 40))
        ],
      ),
      // const SizedBox(
      //   width: 20,
      // ),
      const Spacer(),
      ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.orange),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () {
            Navigator.pushNamed(
                context,
                PizzaMaker.routeName
            );
          },
          child: const Text("Make your Own Pizza")),
      // Image(
      //   image: AssetImage("assets/logo.jpg"),
      //   width: 150,
      //   height: 150,
      //   fit: BoxFit.fill,
      // )
    ],
  );
}

Widget tabs() {
  return SizedBox(
    height: 580,
    width: double.infinity,
    child: BlocProvider(
      create: (context) => GetCategoriesCubit()..getCategories(),
      child: BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
        builder: (context, categoryState) {
          if (categoryState is GetCategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (categoryState is GetCategoriesFailure) {
            return Center(child: Text(categoryState.message));
          } else if (categoryState is GetCategoriesSuccess) {

            if (categoryState.categories.isEmpty) {
              return const Center(child: Text("No Categories Found"));
            } else {
              getMealsCubit.getMeals( categoryState.categories[tabIndex].id);
              return DefaultTabController(
                initialIndex: 0,
                length: categoryState.categories.length,
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(20),
                      child: Container(
                        color: Colors.transparent,
                        child: SafeArea(
                          /*
                  safearea : A widget that insets its child by sufficient padding to avoid intrusions by the operating system.
                  for more visit : https://www.youtube.com/watch?v=lkF0TQJO0bA
                */

                          child: Column(
                            children: <Widget>[
                              TabBar(
                                onTap: (index){
                                  tabIndex = index;
                                    getMealsCubit.getMeals(categoryState.categories[index].id);
                                },
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
                                tabs: categoryState.categories
                                    .map((e) => Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Tab(text: e.data().name),
                                    ))
                                    .toList(),
                                // <Widget>[
                                //   const Text("Pizza"),
                                //   Container(
                                //     padding: const EdgeInsets.only(left: 40, right: 20),
                                //     child: const Text("Rolls"),
                                //   ),
                                //   Container(
                                //     padding: const EdgeInsets.only(left: 40, right: 20),
                                //     child: const Text("Burgers"),
                                //   ),
                                //   Container(
                                //     padding: const EdgeInsets.only(left: 40, right: 40),
                                //     child: const Text("Sandwiches"),
                                //   ),
                                // ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  body: BlocBuilder<GetMealsCubit, GetMealsState>(
                    bloc: getMealsCubit,
                    builder: (context, state) {
                      if(state is GetMealsLoading){
                        return const Center(child: CircularProgressIndicator());
                      }else if(state is GetMealsFailure){
                        return Center(child: Text(state.message!));
                      }else if(state is GetMealsSuccess){
                        return TabBarView(

                          children: categoryState.categories.map((e) =>
                              pizzaShowCase(
                                  mealModel: state.data,
                                  mealCount: state.data.length,
                                categoryID: e.id
                              )).toList(),
                         // children: state.data.map((e) => pizzaShowCase(mealModel: e,mealCount: state.data.length)).toList(),
                        );
                      }else{
                        return const Center(child: Text("Unknown Statee"));
                      }

                      // return TabBarView(
                      //   children:
                      //
                      //   // <Widget>[
                      //   //   // pizzaShowCase(),
                      //   //   const Center(
                      //   //     child: Text(
                      //   //       "Rolls Tab",
                      //   //       textAlign: TextAlign.center,
                      //   //       style: TextStyle(fontSize: 15),
                      //   //     ),
                      //   //   ),
                      //   //   const Center(
                      //   //     child: Text(
                      //   //       "Rolls Tab",
                      //   //       textAlign: TextAlign.center,
                      //   //       style: TextStyle(fontSize: 15),
                      //   //     ),
                      //   //   ),
                      //   // ],
                      // );
                    },
                  ),
                ),
              );
            }
          } else {
            return const Center(child: Text("Unknown State"));
          }
        },
      ),
    ),
  );
}

Widget pizzaShowCase({
  required List<QueryDocumentSnapshot<MealModel>> mealModel,
  required int mealCount,
  required String categoryID
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: mealCount,
      itemBuilder: (BuildContext context, int i) {
        return InkWell(
          onTap: (){
            Navigator.of(context).pushNamed(Details.routeName,arguments:
            MealScreenArgument(mealModel:  mealModel[i].data(), categoryID:categoryID)


            );

          },
          child: ListOfPizzas(
            description: mealModel[i].data().description??"",
            name: mealModel[i].data().name??"",
            image: mealModel[i].data().imageUrl??"",
            price: mealModel[i].data().price??"0",
           // background: pizza[i].background,
            //foreground: pizzaList.pizzas[i].foreground,
          //  pizzaObject: pizza[i],
          ),
        );
      },
    ),
  );
}

class ListOfPizzas extends StatelessWidget {
  const ListOfPizzas(
      {super.key,
      // required this.foreground,
     // required this.background,
        required this.description,
      required this.price,
      required this.name,
      required this.image,
      //required this.pizzaObject
      });

  //final Color foreground;
 // final Color background;
  final String price;
  final String name;
  final String image;
  final String description;
 // final Pizza pizzaObject;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: 225,
          decoration: BoxDecoration(
            color: ColorHelper.mainColor,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 150,
                child: CachedNetworkImage(imageUrl: image),
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                softWrap: true,
                text: TextSpan(
                    style: const TextStyle(fontSize: 25, fontFamily: "slabo"),
                    children: [
                      TextSpan(text: name,style: const TextStyle(
                        fontWeight: FontWeight.w900
                      )),
                       TextSpan(
                          text: "\n$description",
                          style: const TextStyle(
                            fontSize: 15,
                          ))
                    ]),
              ),
              const Spacer(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text("$price LE",
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            // color: foreground,
                            fontFamily: "arial")),
                  ),
                  // StatefulFavIcon(
                  //   foreground: foreground,
                  // )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 40,
        )
      ],
    );
  }
}

class StatefulFavIcon extends StatefulWidget {
  const StatefulFavIcon({super.key, required this.foreground});

  final Color foreground;

  @override
  _StatefulFavIconState createState() => _StatefulFavIconState();
}

class _StatefulFavIconState extends State<StatefulFavIcon> {
  late bool isFav;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFav = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isFav = !isFav;
        });
      },
      child: Icon(
        isFav ? Icons.favorite : Icons.favorite_border,
        color: widget.foreground,
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  CupertinoIcons.home,
                  size: 30,
                )),
            // IconButton(
            //     onPressed: () {},
            //     icon: const Icon(
            //       CupertinoIcons.search,
            //       size: 30,
            //     )),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context,
                      CartPage.routeName);
                },
                icon: const Icon(
                  CupertinoIcons.cart,
                  size: 30,
                )),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProfilePage()));
                },
                icon: const Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                )),
          ],
        ),
      ),
    );
  }
}

class MealScreenArgument {
  String categoryID;
  MealModel mealModel;
  MealScreenArgument({required this.mealModel, required this.categoryID});
}
