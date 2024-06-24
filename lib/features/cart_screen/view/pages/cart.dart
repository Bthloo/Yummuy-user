import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ummuy2/core/data_base/models/admin_cart_model.dart';
import 'package:ummuy2/core/data_base/my_database.dart';
import 'package:ummuy2/core/general_components/build_show_toast.dart';
import 'package:ummuy2/features/auth/Login/ViewModel/login_cubit.dart';
import 'package:ummuy2/features/cart_screen/viewmodel/cart_cubit.dart';
import 'package:ummuy2/features/profile_screen/view/pages/propag.dart';
import 'package:ummuy2/features/profile_screen/viewmodel/profile_cubit.dart';

import '../../../../core/data_base/models/cart_model.dart';
import '../../../profile_screen/viewmodel/profile_state.dart';

class CartPage extends StatelessWidget {
  CartPage({super.key});
  static const routeName = 'cart screen';
  BuildContext? cartContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your cart',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocProvider(
            create: (context) => CartCubit()..getCart(),
            child: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                cartContext = context;
                if (state is CartLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CartError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is CartSuccess) {
                  if (state.cartItems.isNotEmpty) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Card(
                                        color: ColorManager.first,
                                        child: ListTile(
                                          onTap: (){
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text("Show Pizza Maker Details"),
                                                  content: Text(state.cartItems[index].pizzaMaker!),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: const Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: state.cartItems[index].image != "" ?
                                            CachedNetworkImage(
                                              width: 100,
                                              height: 100,
                                              imageUrl:
                                                  state.cartItems[index].image!,
                                            ): const SizedBox(
                                                width: 100,
                                                height: 100,
                                                child: Icon(Icons.image)),
                                          ),
                                          title: Text(
                                            state.cartItems[index].name!,
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.second,
                                            ),
                                          ),
                                          subtitle: Text(
                                            '${state.cartItems[index].price} LE',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: ColorManager.second,
                                            ),
                                          ),
                                          trailing: Text(
                                            "${state.cartItems[index].quantity} x ${state.cartItems[index].size}",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: ColorManager.second,
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: IconButton(
                                          onPressed: () {
                                            try {
                                              MyDataBase.deleteCart(
                                                cartModel:
                                                    state.cartItems[index],
                                                id: LoginCubit.currentUser.id!,
                                              );
                                              CartCubit.get(cartContext!)
                                                  .getCart();
                                            } on Exception catch (e) {
                                              buildShowToast(e.toString());
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          )),
                                    )
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: state.cartItems.length),
                        ),
                        //const Spacer(),
                        BottomAppBar(
                          child: SizedBox(
                            height: 100,
                            // padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total:',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  '${CartCubit.get(context).totalPrice} LE',
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const Spacer(),
                                BlocProvider(
                                  create: (context) => ProfileCubit()..getUserFromDataBase(),
                                  child:
                                      BlocBuilder<ProfileCubit, ProfileState>(
                                    builder: (context, profileState) {
                                      if(profileState is ProfileSuccess){
                                        return ElevatedButton(
                                          onPressed: () {
                                            if (profileState.user.address ==
                                                null ||
                                                profileState.user.address ==
                                                    "" ||
                                                profileState.user.address ==
                                                    "No Address yet") {
                                              showAdaptiveDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Please add your address'),
                                                    content: const Text(
                                                        'You have to add your address to be able to checkout'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                        const Text('Cancel'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pushNamed(
                                                              ProfilePage
                                                                  .routeName).then((value) {
                                                            ProfileCubit.get(context).getUserFromDataBase();
                                                                  },);
                                                        },
                                                        child: const Text(
                                                            'Add Address'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ).then((value) {
                                                ProfileCubit.get(context).getUserFromDataBase();
                                              },);
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) =>
                                                    _buildPopupDialog(
                                                        context,
                                                        state.cartItems,
                                                        state.cartItems.length,
                                                        CartCubit.get(
                                                            cartContext!)
                                                            .totalPrice),
                                              );
                                            }
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 4),
                                            child: Text(
                                              'Checkout',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        );
                                      }else if(profileState is ProfileLoading){
                                        return const Center(child: CircularProgressIndicator(),);
                                      }else if(profileState is ProfileError){
                                        return  Center(child: Text(profileState.e));
                                    }else{
                                        return const Center(child: Text('unknown state'),);
                                      }
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text('No items in your cart'),
                    );
                  }
                } else {
                  return const Center(
                    child: Text('unknown state'),
                  );
                }
              },
            ),
          )),
      // bottomNavigationBar:BottomAppBar(
      //       child: Container(
      //         height: 100,
      //         padding: EdgeInsets.symmetric(horizontal: 16),
      //         child: Row(
      //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text('Total:',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      //             SizedBox(width: 10,),
      //             Text('${CartCubit.get(context).totalPrice} LE',style: TextStyle(fontSize: 20),),
      //             SizedBox(width: 60,),
      //
      //             ElevatedButton(
      //               onPressed: () {
      //                 showDialog(
      //                   context: context,
      //                   builder: (BuildContext context) => _buildPopupDialog(context),
      //                 );
      //               },
      //               child: Padding(padding: EdgeInsets.symmetric(vertical: 4,horizontal: 4),
      //               child: Text('Checkout',style: TextStyle(fontSize: 20,color: Colors.black),),),
      //             ),
      //           ],
      //         ),
      //       ),
      //     )
    );
  }

  Widget _buildPopupDialog(BuildContext context, List<CartModel> cartModel,
      int length, double totalPrice) {
    return AlertDialog(
      title: const Text(
        'Confirmation',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              child: Text(
                "About 30 - 45 min ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 10,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              child: Text(
                "Are you sure to confirm?",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          const SizedBox(
            height: 20,
          ),

          //price
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              child: Text(
                "Total Price: ${CartCubit.get(cartContext!).totalPrice} LE",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),

          //des
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            try {
              MyDataBase.addCartAmdin(
                  cartAmdinModel: CartAmdinModel(
                      status: "Pending",
                      cartModelList: cartModel,
                      totalPrice: totalPrice,
                      userAddress: LoginCubit.currentUser.address,
                      userPhone: LoginCubit.currentUser.phoneNumber,
                      userName: LoginCubit.currentUser.name,
                      userId: LoginCubit.currentUser.id!,
                      userEmail: LoginCubit.currentUser.email,
                      time: DateTime.now().toString()),
                  uId: LoginCubit.currentUser.id!);
              // MyDataBase.addToHistory(
              //     cartAdminModel:  CartAmdinModel(
              //       status: "Pending",
              //         cartModelList: cartModel,
              //         totalPrice: totalPrice,
              //         userAddress: LoginCubit.currentUser.address,
              //         userPhone: LoginCubit.currentUser.phoneNumber,
              //         userName: LoginCubit.currentUser.name,
              //         userId: LoginCubit.currentUser.id!,
              //         userEmail: LoginCubit.currentUser.email,
              //         time: DateTime.now().toString()
              //     ),
              //     id: LoginCubit.currentUser.id!
              // );

              for (int i = 0; i < length; i++) {
                MyDataBase.deleteCart(
                    cartModel: cartModel[i], id: LoginCubit.currentUser.id!);
              }

              Navigator.of(context).pop();
              CartCubit.get(cartContext!).getCart();
              buildShowToast("Order has been confirmed");
            } on Exception catch (e) {
              buildShowToast(e.toString());
            }
          },
          child: const Text(
            'Confirm',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
