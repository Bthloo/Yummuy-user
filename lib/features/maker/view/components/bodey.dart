import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/pizza_maker_cubit.dart';

class BodyWidget extends StatelessWidget {
   BodyWidget({super.key, required this.totalPrice, required this.isSelected});
int totalPrice;
bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: TabBarView(
        children: [
          BlocProvider(
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
                  return Column(
                      children: [
                        const Text("Select your toppings"),
                        Wrap(
                          children: state.pizzaMakerModel.toppings!.map((e) {
                            return
                              Container(
                                margin: const EdgeInsets.all(5),
                                child: StatefulBuilder(
                                  builder: (context, setStatee) {
                                    return ChoiceChip(
                                      onSelected: (value) {
                                        if(value){
                                          totalPrice += e.price!;
                                        }else{
                                          totalPrice -= e.price!;
                                        }
                                        setStatee(() {
                                          isSelected = value;
                                        });
                                        debugPrint("Total Price: $totalPrice");
                                      },
                                      label: Text("${e.name}"),
                                      selected: isSelected,
                                    );
                                  },
                                ),
                              );
                          }).toList(),

                        ),


                      ]
                  );
                }else{
                  return const SizedBox();
                }

              },
            ),
          ),
          Column(
              children: [
                Text("Select your Cheese"),

              ]
          ),
          Column(
              children: [
                Text("Select your Sauce"),
              ]
          ),
          Column(
              children: [
                Text("Select your Vegetables"),
              ]
          ),
          Column(
              children: [
                Text("Select your Pickles"),
              ]
          ),

        ],
      ),
    );
  }
}
