import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummuy2/core/data_base/models/cart_model.dart';
import 'package:ummuy2/core/data_base/models/pizza_maker_admin_cart.dart';
import 'package:ummuy2/core/data_base/my_database.dart';
import 'package:ummuy2/core/general_components/build_show_toast.dart';

import '../../../../core/data_base/models/PizzaMakerAdminNew.dart';
import '../../../auth/Login/ViewModel/login_cubit.dart';
import '../../viewmodel/pizza_maker_cubit.dart';

class PizzaMaker extends StatelessWidget {
   PizzaMaker({super.key});

  static const String routeName = "pizza-maker";

  final PageController pageController = PageController();

bool isToppingsSelected = false;
bool isCheeseSelected = false;
bool isSauceSelected = false;
bool isVegetablesSelected = false;
bool isCrustSelected = false;
BuildContext? cubitContext ;

int totalPrice = 0;
   final ValueNotifier<int> price = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                const SizedBox(width: 10,),
                ValueListenableBuilder<int>(
                    valueListenable: price,
                    builder: (context, value, _) {
                      return Text('$value',style: const TextStyle(fontSize: 20),);
                    },
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    try{
                      PizzaMakerAdminNew pizzaMakerAdmin = PizzaMakerAdminNew(
                        crust: [],
                        toppings: [],
                        sauce: [],
                        vegetables: [],
                        cheeses: [],
                      );
                      cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.crusts?.forEach((element) {
                        pizzaMakerAdmin.crust?.add(element.name!);
                      },);
                      cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.toppings?.forEach((element) {
                        pizzaMakerAdmin.toppings?.add(element.name!);
                      },);
                      cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.sauces?.forEach((element) {
                        pizzaMakerAdmin.sauce?.add(element.name!);
                      },);
                      cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.vegetables?.forEach((element) {
                        pizzaMakerAdmin.vegetables?.add(element.name!);
                      },);
                      cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.cheeses?.forEach((element) {
                        pizzaMakerAdmin.cheeses?.add(element.name!);
                      },);
                      String piz = pizzaMakerAdmin.toJson().toString();
                      // String pizzaaa ="${cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.toJson()}";
                      // List<String> list = pizzaaa.split(",");
                      if(
                      cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.toppings!.isEmpty ||
                          cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.cheeses!.isEmpty ||
                          cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.sauces!.isEmpty ||
                          cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.vegetables!.isEmpty ||
                          cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.crusts!.isEmpty
                      ){
                        buildShowToast("Please Select All Fields");
                      }else{
                        MyDataBase.addToCart(
                            cartModel: CartModel(
                              name: "Custom Pizza",
                              status: "Pending",
                              pizzaMaker: piz,
                              quantity: 1,
                              image: "",
                              size: "Large",
                              price: totalPrice.toDouble(),
                            ),
                            id: LoginCubit.currentUser.id
                        );
                        buildShowToast("Added To Cart Successfully");
                        Navigator.pop(context);
                      }


                    }catch(e){
                      buildShowToast(e.toString());
                    }
                  },
                    // onPressed: (){
                    //   showDialog(
                    //       context: context,
                    //       builder: (context) {
                    //         return Dialog(
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Stack(
                    //               alignment: Alignment.bottomCenter,
                    //               children: [
                    //
                    //                 Flex(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   direction: Axis.vertical,
                    //                 children: [
                    //                   const SizedBox(height: 50,),
                    //                   Text('Total Price: $totalPrice',style: const TextStyle(fontSize: 20),),
                    //                   const SizedBox(height: 30,),
                    //                  // const Text('Toppings:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    //                   Flexible(
                    //                     child: ExpansionTile(
                    //                       title: const Text('Toppings',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    //                       children: [
                    //                         Padding(
                    //                           padding: const EdgeInsets.all(10.0),
                    //                           child: ListView.separated(
                    //                            // shrinkWrap: true,
                    //                             separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    //                             physics: const NeverScrollableScrollPhysics(),
                    //                             itemCount: cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.toppings!.length,
                    //                             itemBuilder: (context, index) {
                    //                               return Text(
                    //                                 '${cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.toppings![index].name}',
                    //                                 style: const TextStyle(fontSize: 25),
                    //                               );
                    //                             },
                    //                           ),
                    //                         )
                    //                       ],
                    //                     //  child: ,
                    //                     ),
                    //                   ),
                    //                   const SizedBox(height: 10,),
                    //                   //const Text('Cheese:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    //                   Flexible(
                    //                     child: ExpansionTile(
                    //                       title: const Text('Cheese',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    //
                    //                       children:[ Padding(
                    //                         padding: const EdgeInsets.all(10.0),
                    //                         child: ListView.separated(
                    //                           shrinkWrap: true,
                    //
                    //                           separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    //                           physics: const NeverScrollableScrollPhysics(),
                    //                           itemCount: cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.cheeses!.length,
                    //                           itemBuilder: (context, index) {
                    //                             return Text(
                    //                               '${cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.cheeses![index].name}',
                    //                               style: const TextStyle(fontSize: 25),
                    //                             );
                    //                           },
                    //                         ),
                    //                       ),]
                    //                     ),
                    //                   ),
                    //                   const SizedBox(height: 10,),
                    //                  // const Text('Sauce:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    //                   Flexible(
                    //                     child: ExpansionTile(
                    //                       title: const Text('Sauce',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    //                       children: [Padding(
                    //                         padding: const EdgeInsets.all(10.0),
                    //                         child: ListView.separated(
                    //                           shrinkWrap: true,
                    //
                    //                           separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    //                           physics: const NeverScrollableScrollPhysics(),
                    //                           itemCount: cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.sauces!.length,
                    //                           itemBuilder: (context, index) {
                    //                             return Text(
                    //                               '${cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.sauces![index].name}',
                    //                               style: const TextStyle(fontSize: 25),
                    //                             );
                    //                           },
                    //                         ),
                    //                       ),]
                    //                     ),
                    //                   ),
                    //                   const SizedBox(height: 10,),
                    //                  // const Text('Vegetables:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    //                   Flexible(
                    //                     child: ExpansionTile(
                    //                       title: const Text('Vegetables',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    //                       children: [Padding(
                    //                         padding: const EdgeInsets.all(10.0),
                    //                         child: ListView.separated(
                    //                          shrinkWrap: true,
                    //
                    //                           separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    //                           physics: const NeverScrollableScrollPhysics(),
                    //                           itemCount: cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.vegetables!.length,
                    //                           itemBuilder: (context, index) {
                    //                             return Text(
                    //                               '${cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.vegetables![index].name}',
                    //                               style: const TextStyle(fontSize: 25),
                    //                             );
                    //                           },
                    //                         ),
                    //                       ),]
                    //                     ),
                    //                   ),
                    //                   const SizedBox(height: 10,),
                    //                  // const Text('Crust:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    //                   Flexible(
                    //                     child: ExpansionTile(
                    //                       title: const Text('Crust',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    //                       children:[ Padding(
                    //                         padding: const EdgeInsets.all(10.0),
                    //                         child: ListView.separated(
                    //                           shrinkWrap: true,
                    //
                    //                           separatorBuilder: (context, index) => const SizedBox(height: 10,),
                    //                           physics: const NeverScrollableScrollPhysics(),
                    //                           itemCount: cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.crusts!.length,
                    //                           itemBuilder: (context, index) {
                    //                             return Text(
                    //                               '${cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.crusts![index].name}',
                    //                               style: const TextStyle(fontSize: 25),
                    //                             );
                    //                           },
                    //                         ),
                    //                       ),]
                    //                     ),
                    //                   ),
                    //                   const SizedBox(height: 30,),
                    //                 ],
                    //               ),
                    //                 Positioned(
                    //                     top: 0,
                    //                     left: 0,
                    //                     right: 0,
                    //                     child: Container(
                    //                       color: Colors.white,
                    //                       child: const Center(
                    //                         child: Text(
                    //                           'Order Summary',
                    //                           style: TextStyle(
                    //                               fontSize: 25,
                    //                               fontWeight: FontWeight.bold,
                    //                             color: Colors.orange
                    //                           ),
                    //                         ),
                    //                       ),
                    //                     )),
                    //                 Container(
                    //                   color: Colors.white,
                    //                   child: Row(
                    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //                     children: [
                    //                       ElevatedButton(
                    //                         onPressed: () {
                    //                           try{
                    //                             PizzaMakerAdminNew pizzaMakerAdmin = PizzaMakerAdminNew(
                    //                               crust: [],
                    //                               toppings: [],
                    //                               sauce: [],
                    //                               vegetables: [],
                    //                               cheeses: [],
                    //                             );
                    //                             cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.crusts?.forEach((element) {
                    //                               pizzaMakerAdmin.crust?.add(element.name!);
                    //                             },);
                    //                             cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.toppings?.forEach((element) {
                    //                               pizzaMakerAdmin.toppings?.add(element.name!);
                    //                             },);
                    //                             cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.sauces?.forEach((element) {
                    //                               pizzaMakerAdmin.sauce?.add(element.name!);
                    //                             },);
                    //                             cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.vegetables?.forEach((element) {
                    //                               pizzaMakerAdmin.vegetables?.add(element.name!);
                    //                             },);
                    //                             cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.cheeses?.forEach((element) {
                    //                               pizzaMakerAdmin.cheeses?.add(element.name!);
                    //                             },);
                    //                             String piz = pizzaMakerAdmin.toJson().toString();
                    //                            // String pizzaaa ="${cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.toJson()}";
                    //                            // List<String> list = pizzaaa.split(",");
                    //                             if(
                    //                             cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.toppings!.isEmpty ||
                    //                                 cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.cheeses!.isEmpty ||
                    //                                 cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.sauces!.isEmpty ||
                    //                                 cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.vegetables!.isEmpty ||
                    //                                 cubitContext!.read<PizzaMakerCubit>().pizzaMakerItem.crusts!.isEmpty
                    //                             ){
                    //                               buildShowToast("Please Select All Fields");
                    //                             }else{
                    //                               MyDataBase.addToCart(
                    //                                   cartModel: CartModel(
                    //                                     name: "Custom Pizza",
                    //                                     status: "Pending",
                    //                                     pizzaMaker: piz,
                    //                                     quantity: 1,
                    //                                     image: "",
                    //                                     size: "Large",
                    //                                     price: totalPrice.toDouble(),
                    //                                   ),
                    //                                   id: LoginCubit.currentUser.id
                    //                               );
                    //                               buildShowToast("Added To Cart Successfully");
                    //                               Navigator.pop(context);
                    //                             }
                    //
                    //
                    //                           }catch(e){
                    //                             buildShowToast(e.toString());
                    //                           }
                    //                         },
                    //                         child: const Text('Add To Cart',
                    //                           style: TextStyle(
                    //                               fontSize: 20,
                    //                               color: Colors.black
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       ElevatedButton(
                    //                         onPressed: () {
                    //                           Navigator.pop(context);
                    //                         },
                    //                         child: const Text('Close',style: TextStyle(fontSize: 20,color: Colors.black),),
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ]
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //   );
                    // },
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all(Colors.white),
                    backgroundColor: WidgetStateProperty.all(Colors.orange),

                  ),
                    child: const Padding(padding: EdgeInsets.symmetric(vertical: 4,horizontal: 4),
                      child: Text('Create ',style: TextStyle(fontSize: 20,color: Colors.black),),),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Pizza Maker',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.orange,
            ),
          ),
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            indicatorColor: Colors.orange,
            labelColor: Colors.orange,
            isScrollable: true,
            tabs: [
              Text("Toppings", style: TextStyle(
                fontSize: 20,

              ),),
              Text("Cheese", style: TextStyle(
                fontSize: 20,

              ),),
              Text("Sauce", style: TextStyle(
                fontSize: 20,

              ),),
              Text("Vegetables", style: TextStyle(
                fontSize: 20,

              ),),
              Text("Crust", style: TextStyle(
                fontSize: 20,

              ),),
            ],

          ),
        ),

        body: Padding(
          padding: EdgeInsets.all(10.0),
          child:  BlocProvider(
            create: (context) =>
            PizzaMakerCubit()
              ..getPizzaMaker(),
            child: BlocBuilder<PizzaMakerCubit, PizzaMakerState>(
              builder: (context, state) {
                if(state is PizzaMakerLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );}else if(state is PizzaMakerError) {
                  return Center(child: Text(state.message),);
                }else if(state is PizzaMakerLoaded){
                  cubitContext = context;
                  var cubit = context.read<PizzaMakerCubit>();
                  return TabBarView(
                    children: [
                      Column(
                          children: [
                            SizedBox(height: 20,),

                            const Text("Select your Toppings",style: TextStyle(
                              fontSize: 30,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,

                            ),),
                            SizedBox(height: 20,),
                            Expanded(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.pizzaMakerModel.toppings!.length,
                                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                     crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                     mainAxisSpacing: 0,
                                     mainAxisExtent: 40.h

                                     // childAspectRatio: 3 / 2,
                                    //  crossAxisSpacing: 10,
                                    //  mainAxisSpacing: 10
                                  ),
                                  itemBuilder: (context, index) {
                                    return StatefulBuilder(
                                      builder: (context, setStatee) {
                                        return ChoiceChip(
                                          selectedColor: Colors.orange,
                                          showCheckmark: false,
                                          onSelected: (value) {
                                            if(value){
                                              cubit.pizzaMakerItem.toppings?.add(state.pizzaMakerModel.toppings![index]);
                                              totalPrice += state.pizzaMakerModel.toppings![index].price!;
                                              price.value += state.pizzaMakerModel.toppings![index].price!;
                                            }else{
                                              cubit.pizzaMakerItem.toppings?.remove(state.pizzaMakerModel.toppings![index]);
                                              totalPrice -= state.pizzaMakerModel.toppings![index].price!;
                                              price.value -= state.pizzaMakerModel.toppings![index].price!;
                                            }
                                            setStatee(() {
                                              cubit.isToppingSelected[index] = value;
                                            });
                                            debugPrint("Total Price: $totalPrice");
                                          },
                                          label: Text("${state.pizzaMakerModel.toppings![index].name}",style: const TextStyle(
                                            color: Colors.black,
                                          ),),
                                          selected: cubit.isToppingSelected[index],
                                        );
                                      },
                                    );
                                  },
                              ),
                            ),

                            // Wrap(
                            //   children: state.pizzaMakerModel.toppings!.map((e) {
                            //     return
                            //       Container(
                            //         margin: const EdgeInsets.all(5),
                            //         child: StatefulBuilder(
                            //           builder: (context, setStatee) {
                            //             return ChoiceChip(
                            //               selectedColor: Colors.orange,
                            //               showCheckmark: false,
                            //               onSelected: (value) {
                            //                 if(value){
                            //                   totalPrice += e.price!;
                            //                   price.value += e.price!;
                            //                 }else{
                            //                   totalPrice -= e.price!;
                            //                   price.value -= e.price!;
                            //                 }
                            //                 setStatee(() {
                            //                   isToppingsSelected = value;
                            //                 });
                            //                 debugPrint("Total Price: $totalPrice");
                            //               },
                            //               label: Text("${e.name}",style: const TextStyle(
                            //                 color: Colors.black,
                            //               ),),
                            //               selected: cubit.isToppingSelected[e],
                            //             );
                            //           },
                            //         ),
                            //       );
                            //   }).toList(),
                            //
                            // ),


                          ]
                      ),
                      Column(
                          children: [
                            const Text("Select your Cheese",style: TextStyle(
                              fontSize: 30,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,

                            ),),
                            Expanded(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.pizzaMakerModel.cheeses!.length,
                                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    mainAxisExtent: 40.h

                                  // childAspectRatio: 3 / 2,
                                  //  crossAxisSpacing: 10,
                                  //  mainAxisSpacing: 10
                                ),
                                itemBuilder: (context, index) {
                                  return StatefulBuilder(
                                    builder: (context, setStatee) {
                                      return ChoiceChip(
                                        selectedColor: Colors.orange,
                                        showCheckmark: false,
                                        onSelected: (value) {
                                          if(value){
                                            cubit.pizzaMakerItem.cheeses?.add(state.pizzaMakerModel.cheeses![index]);
                                            totalPrice += state.pizzaMakerModel.cheeses![index].price!;
                                            price.value += state.pizzaMakerModel.cheeses![index].price!;
                                          }else{
                                            cubit.pizzaMakerItem.cheeses?.remove(state.pizzaMakerModel.cheeses![index]);
                                            totalPrice -= state.pizzaMakerModel.cheeses![index].price!;
                                            price.value -= state.pizzaMakerModel.cheeses![index].price!;
                                          }
                                          setStatee(() {
                                            cubit.isCheeseSelected[index] = value;
                                          });
                                          debugPrint("Total Price: $totalPrice");
                                        },
                                        label: Text("${state.pizzaMakerModel.cheeses![index].name}",style: const TextStyle(
                                          color: Colors.black,
                                        ),),
                                        selected: cubit.isCheeseSelected[index],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),


                          ]
                      ),
                      Column(
                          children: [
                            const Text("Select your Sauce",style: TextStyle(
                              fontSize: 30,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,

                            ),),
                            Expanded(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.pizzaMakerModel.sauces!.length,
                                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    mainAxisExtent: 40.h

                                  // childAspectRatio: 3 / 2,
                                  //  crossAxisSpacing: 10,
                                  //  mainAxisSpacing: 10
                                ),
                                itemBuilder: (context, index) {
                                  return StatefulBuilder(
                                    builder: (context, setStatee) {
                                      return ChoiceChip(
                                        selectedColor: Colors.orange,
                                        showCheckmark: false,
                                        onSelected: (value) {
                                          if(value){
                                            cubit.pizzaMakerItem.sauces?.add(state.pizzaMakerModel.sauces![index]);

                                            totalPrice += state.pizzaMakerModel.sauces![index].price!;
                                            price.value += state.pizzaMakerModel.sauces![index].price!;
                                          }else{
                                            cubit.pizzaMakerItem.sauces?.remove(state.pizzaMakerModel.sauces![index]);
                                            totalPrice -= state.pizzaMakerModel.sauces![index].price!;
                                            price.value -= state.pizzaMakerModel.sauces![index].price!;
                                          }
                                          setStatee(() {
                                            cubit.isSauceSelected[index] = value;
                                          });
                                          debugPrint("Total Price: $totalPrice");
                                        },
                                        label: Text("${state.pizzaMakerModel.sauces![index].name}",style: const TextStyle(
                                          color: Colors.black,
                                        ),),
                                        selected: cubit.isSauceSelected[index],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),


                          ]
                      ),
                      Column(
                          children: [
                            const Text("Select your Vegetables",style: TextStyle(
                              fontSize: 30,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,

                            ),),
                            Expanded(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.pizzaMakerModel.vegetables!.length,
                                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    mainAxisExtent: 40.h

                                  // childAspectRatio: 3 / 2,
                                  //  crossAxisSpacing: 10,
                                  //  mainAxisSpacing: 10
                                ),
                                itemBuilder: (context, index) {
                                  return StatefulBuilder(
                                    builder: (context, setStatee) {
                                      return ChoiceChip(
                                        selectedColor: Colors.orange,
                                        showCheckmark: false,
                                        onSelected: (value) {
                                          if(value){
                                            cubit.pizzaMakerItem.vegetables?.add(state.pizzaMakerModel.vegetables![index]);
                                            totalPrice += state.pizzaMakerModel.vegetables![index].price!;
                                            price.value += state.pizzaMakerModel.vegetables![index].price!;
                                          }else{
                                            cubit.pizzaMakerItem.vegetables?.remove(state.pizzaMakerModel.vegetables![index]);
                                            totalPrice -= state.pizzaMakerModel.vegetables![index].price!;
                                            price.value -= state.pizzaMakerModel.vegetables![index].price!;
                                          }
                                          setStatee(() {
                                            cubit.isVegetablesSelected[index] = value;
                                          });
                                          debugPrint("Total Price: $totalPrice");
                                        },
                                        label: Text("${state.pizzaMakerModel.vegetables![index].name}",style: const TextStyle(
                                          color: Colors.black,
                                        ),),
                                        selected: cubit.isVegetablesSelected[index],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),


                          ]
                      ),
                      Column(
                          children: [
                            const Text("Select your Crust",style: TextStyle(
                              fontSize: 30,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,

                            ),),
                            Expanded(
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.pizzaMakerModel.crusts!.length,
                                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    mainAxisExtent: 40.h

                                  // childAspectRatio: 3 / 2,
                                  //  crossAxisSpacing: 10,
                                  //  mainAxisSpacing: 10
                                ),
                                itemBuilder: (context, index) {
                                  return StatefulBuilder(
                                    builder: (context, setStatee) {
                                      return ChoiceChip(
                                        selectedColor: Colors.orange,
                                        showCheckmark: false,
                                        onSelected: (value) {
                                          if(value){
                                            cubit.pizzaMakerItem.crusts?.add(state.pizzaMakerModel.crusts![index]);
                                            totalPrice += state.pizzaMakerModel.crusts![index].price!;
                                            price.value += state.pizzaMakerModel.crusts![index].price!;
                                          }else{
                                            cubit.pizzaMakerItem.crusts?.remove(state.pizzaMakerModel.crusts![index]);
                                            totalPrice -= state.pizzaMakerModel.crusts![index].price!;
                                            price.value -= state.pizzaMakerModel.crusts![index].price!;
                                          }
                                          setStatee(() {
                                            cubit.isCrustSelected[index] = value;
                                          });
                                          debugPrint("Total Price: $totalPrice");
                                        },
                                        label: Text("${state.pizzaMakerModel.crusts![index].name}",style: const TextStyle(
                                          color: Colors.black,
                                        ),),
                                        selected: cubit.isCrustSelected[index],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),


                          ]
                      ),

                    ],
                  );



                }else{
                  return const SizedBox();
                }

              },
            ),
          )
        ),

      ),
    );
  }
}
