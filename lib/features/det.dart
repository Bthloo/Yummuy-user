import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ummuy2/core/data_base/models/cart_model.dart';
import 'package:ummuy2/core/data_base/models/meal_model.dart';
import 'package:ummuy2/core/data_base/my_database.dart';
import 'package:ummuy2/core/general_components/ColorHelper.dart';
import 'package:ummuy2/core/general_components/build_show_toast.dart';
import 'package:ummuy2/features/auth/Login/ViewModel/login_cubit.dart';
import 'package:ummuy2/features/cart_screen/view/pages/cart.dart';
import 'package:ummuy2/features/home_screen/view/pages/mainnn.dart';
import 'package:ummuy2/features/home_screen/viewmodel/get_ingredient/meal_screen_cubit.dart';

class Details extends StatelessWidget {
   Details({super.key});
  static const routeName = "details";
  int number = 1;
   bool isCart = false;
   String? size = "Small";
   double? itemPrice;
   int counter = 0;
  //final Pizza pizzaObject;

  @override
  Widget build(BuildContext context) {
    MealScreenArgument argument =
        ModalRoute.of(context)!.settings.arguments as MealScreenArgument;
    if(counter == 0){
      itemPrice = double.parse(argument.mealModel.price!);
      counter++;
      debugPrint("itemPrice $itemPrice");
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar:   Padding(
        padding: const EdgeInsets.all(8.0),
        child: StatefulBuilder(
          builder : (context,setState){
            return Container(
              decoration: const BoxDecoration(
                  border:
                  Border(bottom: BorderSide(color: Colors.black, width: 5))),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if(size == null){
                        buildShowToast("Please choose the size");
                        return;
                      }
                      else {
                        try {
                          MyDataBase.addToCart(
                              cartModel: CartModel(
                                  id: argument.mealModel.id!,
                                  image: argument.mealModel.imageUrl!,
                                  name: argument.mealModel.name!,
                                  price: itemPrice! * number,
                                  quantity: number,
                                  status: "pending",
                                  size: size

                              ),
                              id: LoginCubit.currentUser.id);
                          buildShowToast("Added to cart successfully");
                        } on Exception catch (e) {
                          buildShowToast(e.toString());
                        }
                      }
                    },
                    child: const Text(
                      "Add to cart",
                      style: TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (number == 1) {
                        return;
                      } else {
                        setState(() {
                          number--;
                        });
                      }
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorHelper.mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "-",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "$number",
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        number++;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorHelper.mainColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "+",
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                 IconButton(
                     onPressed: () {
                        Navigator.pushNamed(context, CartPage.routeName);
                     },
                     icon: const Icon(Icons.shopping_cart_outlined),
                 )
                ],
              ),
            );
          }
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                const BackgroundArc(),
                Column(
                  children: <Widget>[
                    PizzaImage(argument.mealModel.imageUrl!),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TitleText(argument.mealModel.name!),
                          const SizedBox(height: 20),
                          // StarRating(pizzaObject.starRating),
                          // const SizedBox(height: 20),
                          Description(argument.mealModel.description!),
                          const SizedBox(height: 20),
                          StatefulBuilder(
                            builder: (context, setState) {
                              return Row(
                                children: [
                                  Text(
                                    "$itemPrice LE",
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
                                  ),
                                  const Spacer(),
                                  DropdownButton(

                                    hint: const Text("Choose the size"),
                                    style: const TextStyle(
                                        color: Colors.black
                                    ),
                                    value: size,
                                    items:  const [
                                      DropdownMenuItem(
                                        value: "Small",
                                        child: Text("Small",style: TextStyle(
                                            color: Colors.black
                                        ),),
                                      ),
                                      DropdownMenuItem(
                                          value: "Medium",
                                          child: Text("Medium",style: TextStyle(
                                              color: Colors.black
                                          ),)),
                                      DropdownMenuItem(
                                          value: "Large",
                                          child: Text("Large",style: TextStyle(
                                              color: Colors.black
                                          ),)
                                      )],
                                    onChanged: (value) {
                                      setState(() {
                                        size = value.toString();
                                        if(size == "Small"){
                                          itemPrice = double.parse(argument.mealModel.price!);
                                          debugPrint("itemPrice $itemPrice \n size $size");
                                        }
                                        else if(size == "Medium"){
                                          itemPrice = double.parse(argument.mealModel.price!) + 20;
                                        }

                                        else if(size == "Large"){
                                          itemPrice = double.parse(argument.mealModel.price!) + 40;
                                        }
                                      });

                                    },
                                  )
                                ],
                              );
                            },

                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                )


                // ForegroundContent(
                //     pizzaObject: argument.mealModel,
                //   size: size,
                // ),
              ],
            ),
            Expanded(
              child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Text("Gradients:",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 10.h,
                        ),
                        BlocProvider(
                          create: (context) => MealScreenCubit()
                            ..getMeals(
                                categoryId: argument.categoryID,
                                mealId: argument.mealModel.id!),
                          child:
                          BlocBuilder<MealScreenCubit, MealScreenState>(
                            builder: (context, state) {
                              if (state is MealScreenLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is MealScreenFailed) {
                                return Center(
                                  child: Text(state.message),
                                );
                              } else if (state is MealScreenSuccess) {
                                return Expanded(
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        return Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                                "${state.ingredients[index].data().title}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.w500)),
                                            Text(
                                                "X ${state.ingredients[index].data().number}",
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                    FontWeight.w500)),
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                      const Divider(),
                                      itemCount: state.ingredients.length),
                                );
                              } else {
                                return const Center(
                                    child: Text("unkown state"));
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class ForegroundContent extends StatelessWidget {
   ForegroundContent({super.key, required this.pizzaObject,required this.size});

  final MealModel pizzaObject;
  String? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PizzaImage(pizzaObject.imageUrl!),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleText(pizzaObject.name!),
              const SizedBox(height: 20),
              // StarRating(pizzaObject.starRating),
              // const SizedBox(height: 20),
              Description(pizzaObject.description!),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "${pizzaObject.price} LE",
                    style: const TextStyle(
                        color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
                  ),
                  DropdownButton(
                      items: const [
                        DropdownMenuItem(
                          value: "Small",
                          child: Text("Small"),
                        ),
                        DropdownMenuItem(
                            value: "Medium",
                            child: Text("Medium")),
                        DropdownMenuItem(
                            value: "Large",
                            child: Text("Large")
                        )],
                      onChanged: (value) {
                          size = value.toString();
                      },
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ],
    );
  }
}




class Description extends StatelessWidget {
  final String desc;

  const Description(this.desc, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      desc,
      softWrap: true,
      style: const TextStyle(
          color: Colors.black87,
          letterSpacing: 1.3,
          fontSize: 17,
          textBaseline: TextBaseline.alphabetic),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText(this.pizzaName, {super.key});

  final String pizzaName;
  final double _fontSize = 40;

  @override
  Widget build(BuildContext context) {
    return Text(pizzaName,
        style: TextStyle(
            color: Colors.black,
            fontSize: _fontSize,
            fontFamily: "slabo",
            fontWeight: FontWeight.w500));
  }
}

class PizzaImage extends StatelessWidget {
  final String imageURI;

  const PizzaImage(this.imageURI, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: CachedNetworkImage(
        imageUrl: imageURI,
      ),
    );
  }
}

class BackgroundArc extends StatelessWidget {
  const BackgroundArc({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BackgroundPainter(ColorHelper.mainColor),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  BackgroundPainter(this.color);

  final Color color;

  Path path = Path();

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    Paint painter = Paint()..color = color;
    path.moveTo(250, 0);

    /*
      these are very absolute coordinates, thus they are not efficient when you open the app in landscape mode.
      Try finding how you can make them relative to the screen.
      Hint: You would have to use the size parameter which is being passed.
    */

    path.quadraticBezierTo(150, 125, 240, 270);
    path.quadraticBezierTo(300, 345, 450, 350);

    path.lineTo(500, 0);

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}




class PriceWithSize extends StatefulWidget {
   PriceWithSize({super.key, required this.argument, required this.size, required this.itemPrice});
  int itemPrice;
  String size;
  MealScreenArgument argument;

  @override
  State<PriceWithSize> createState() => _PriceWithSizeState();
}

class _PriceWithSizeState extends State<PriceWithSize> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "${widget.itemPrice} LE",
          style: const TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w700),
        ),
        const Spacer(),
        DropdownButton(

          hint: const Text("Choose the size"),
          style: const TextStyle(
              color: Colors.black
          ),
          value: widget.size,
          items:  const [
            DropdownMenuItem(
              value: "Small",
              child: Text("Small",style: TextStyle(
                  color: Colors.black
              ),),
            ),
            DropdownMenuItem(
                value: "Medium",
                child: Text("Medium",style: TextStyle(
                    color: Colors.black
                ),)),
            DropdownMenuItem(
                value: "Large",
                child: Text("Large",style: TextStyle(
                    color: Colors.black
                ),)
            )],
          onChanged: (value) {
            setState(() {
              widget.size = value.toString();
              if(widget.size == "Small"){
                widget.itemPrice = int.parse(widget.argument.mealModel.price!);
                debugPrint("itemPrice ${widget.itemPrice} \n size ${widget.size}");
              }
              else if(widget.size == "Medium"){
                widget.itemPrice = int.parse(widget.argument.mealModel.price!) + 20;
              }

              else if(widget.size == "Large"){
                widget.itemPrice = int.parse(widget.argument.mealModel.price!) + 40;
              }
            });

          },
        )
      ],
    );
  }
}

