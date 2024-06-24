import 'package:flutter/material.dart';

import '../../../auth/Login/View/Pages/login_screen.dart';
import '../../../auth/Login/ViewModel/login_cubit.dart';
import '../../../home_screen/view/pages/mainnn.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const String routeName = "splash_screen";

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(
        context,
        (LoginCubit.currentUser.id == ''|| LoginCubit.currentUser.id == null)
            ?LoginScreen.routeName
            : PizzaHome.routeName,
      );
    });
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text(""),
            ),
            body: Center(
                child: Column(children: [
                  Card(
                    child: Ink.image(
                      image: const AssetImage("assets/logo.jpg"),
                      height: 400,
                      width: 400,child: const Text("ENJOY THE TASTE AND SAY YUMMY.",
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.orange),),
                    ),
                  ),
                ]
                )
            )
        )
    );
  }
}