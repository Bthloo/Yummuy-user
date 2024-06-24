import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/general_components/ColorHelper.dart';
import '../../../../../core/general_components/build_show_toast.dart';
import '../../../../../core/general_components/custom_form_field.dart';
import '../../../../../core/general_components/my_validators.dart';
import '../../../../home_screen/view/pages/mainnn.dart';
import '../../../Register/View/Pages/register_screen.dart';
import '../../ViewModel/login_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  LoginCubit loginCubit = LoginCubit();

  bool keepMeLogged = false;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
     // backgroundColor: const Color(0xff171717),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * .35,
                    child: Image.asset("assets/logo.jpg")),
                // SizedBox(height: 20.h,),
                CustomFormField(
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Enter Your Email',
                    validator: (value) => MyValidators.emailValidator(value),
                    controller: emailController),
                const SizedBox(
                  height: 20,
                ),
                CustomFormField(
                  isPassword: !isVisible,
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      icon: isVisible
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.orange,
                            )
                          : const Icon(Icons.visibility_off,
                             // color: Colors.white
                      )),
                  hintText: 'Enter Your password',
                  validator: (value) => MyValidators.passwordValidator(value),
                  controller: passwordController,
                ),

                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: ColorHelper.mainColor,
                      side: const BorderSide(
                          //color: Colors.white
                      ),
                      overlayColor: WidgetStatePropertyAll(
                          Colors.white.withOpacity(.1)),
                     // checkColor: Colors.white,
                      value: keepMeLogged,
                      onChanged: (value) {
                        setState(() {
                          keepMeLogged = value!;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      'keep Me Logged In',
                      style: TextStyle(
                        fontSize: 16.sp,
                        //color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                buildBlocConsumerMainButton(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't Have an Account ? ",
                      style: TextStyle(
                      //  color: Color(0xffEDEDED),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: const Text("Register")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (formKey.currentState?.validate() == false) {
        return;
      }
      loginCubit.login(
        email: emailController.text,
        password: passwordController.text,
        keepMeLogin: keepMeLogged,
      );
    });
  }

  Widget buildBlocConsumerMainButton() {
    return BlocConsumer<LoginCubit, LoginState>(
      bloc: loginCubit,
      listener: (context, state) {
        if (state is LoginError) {
          buildShowToast(state.message);
        } else if (state is LoginSuccess) {
          buildShowToast(state.message);
          Navigator.pushReplacementNamed(context, PizzaHome.routeName);
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              login();
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        );
      },
    );
  }
}
