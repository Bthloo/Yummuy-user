
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ummuy2/features/cart_screen/view/pages/cart.dart';
import 'package:ummuy2/features/det.dart';
import 'package:ummuy2/features/maker/view/pages/pizza_maker.dart';
import 'package:ummuy2/features/profile_screen/view/pages/history_page.dart';
import 'package:ummuy2/features/profile_screen/viewmodel/profile_state.dart';
import 'package:ummuy2/features/splash_screen/view/pages/splash_screen.dart';

import 'core/data_base/models/user.dart';
import 'core/data_base/my_database.dart';
import 'core/general_components/theme_data.dart';
import 'features/auth/Login/View/Pages/login_screen.dart';
import 'features/auth/Login/ViewModel/login_cubit.dart';
import 'features/auth/Register/View/Pages/register_screen.dart';
import 'features/home_screen/view/pages/mainnn.dart';
import 'features/profile_screen/view/pages/propag.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await  const FlutterSecureStorage().read(key: 'token').then((value) async {
    if (value != null) {
      LoginCubit.currentUser.id = value;
      User? user = await MyDataBase.readUser(LoginCubit.currentUser.id ?? '');
      LoginCubit.currentUser = user!;
    }
    debugPrint('User ID   ${LoginCubit.currentUser.id}');
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Ummuy',
        theme: themeData(context),
        initialRoute:SplashScreen.routeName,
        routes: {
          HistoryPage.routeName : (_) => const HistoryPage(),
         // TabPage.routeName : (_) => const TabPage(),
         PizzaHome.routeName : (_) =>  const PizzaHome(),
          SplashScreen.routeName : (_) => const SplashScreen(),
          RegisterScreen.routeName : (_) => const RegisterScreen(),
          LoginScreen.routeName : (_) => const LoginScreen(),
          Details.routeName : (_) =>   Details(),
          CartPage.routeName : (_) =>    CartPage(),
          ProfilePage.routeName : (_) =>  ProfilePage(),
          PizzaMaker.routeName : (_) =>   PizzaMaker(),
         // HomeScreen.routeName : (_) => const HomeScreen(),
        },
      ),
    );
  }
}


