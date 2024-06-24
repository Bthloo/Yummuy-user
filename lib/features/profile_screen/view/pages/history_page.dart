import 'package:flutter/material.dart';
import 'package:ummuy2/core/data_base/models/admin_cart_model.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});
static const String routeName = 'historyScreen';
  @override
  Widget build(BuildContext context) {
    CartAmdinModel argument = ModalRoute.of(context)!.settings.arguments as CartAmdinModel;
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: ListTile(
                      title: Text("Name: ${argument.cartModelList?[index].name}",
                        style:const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),),
                      subtitle: Text("Price: ${argument.cartModelList?[index].price} LE",
                        style:const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),),
                      trailing: Text("X${argument.cartModelList?[index].quantity}.${argument.cartModelList?[index].size}",
                        style:const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: argument.cartModelList?.length??0)
        ),
      )
    );
  }
}
