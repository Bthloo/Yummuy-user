import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ummuy2/core/data_base/models/user.dart' as my_user;
import 'package:ummuy2/core/data_base/my_database.dart';
import 'package:ummuy2/core/general_components/build_show_toast.dart';
import 'package:ummuy2/core/general_components/custom_form_field.dart';
import 'package:ummuy2/features/auth/Login/View/Pages/login_screen.dart';
import 'package:ummuy2/features/profile_screen/view/pages/history_page.dart';
import 'package:ummuy2/features/profile_screen/viewmodel/profile_cubit.dart';
import '../../viewmodel/history_viewmodel/history_cubit.dart';
import '../../viewmodel/profile_state.dart';

class ColorManager {
  static Color first = const Color(0xffFF7F00); //orange card color
  static Color second = const Color(0xffFFFFFF); //black text color
}

class ProfilePage extends StatelessWidget {
   ProfilePage({super.key});
 final TextEditingController controller = TextEditingController();
 BuildContext? profileContext;
 final formKey = GlobalKey<FormState>();
static const String routeName = 'profile-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('User Profile',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 25,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocProvider(
          create: (context) => ProfileCubit()..getUserFromDataBase(),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              profileContext = context;
              if(state is ProfileLoading) {
                return const Center(child: CircularProgressIndicator(),);
              }
              if(state is ProfileError){
                return  Center(child: Text(state.e),);
              }else if(state is ProfileSuccess){
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                        color: ColorManager.first,
                        child: Column(children: [
                          ListTile(
                            title: Text("Name",
                                style: TextStyle(
                                  color: ColorManager.second,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 25,
                                )),
                            subtitle: Text(state.user.name??"No user",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.second,
                                  fontSize: 20,
                                )),
                            leading: Icon(
                              Icons.person_outline,
                              color: ColorManager.second,
                              size: 30,
                            ),
                          ),
                        ])),
                    Card(
                        color: ColorManager.first,
                        child: Column(children: [
                          ListTile(
                            title: Text("Phone number",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: ColorManager.second,
                                  fontSize: 25,
                                )),
                            subtitle: Text(state.user.phoneNumber??"No Phone number",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.second,
                                  fontSize: 20,
                                )),
                            leading: Icon(
                              Icons.phone_outlined,
                              color: ColorManager.second,
                              size: 30,
                            ),
                          ),
                        ])),
                    Card(
                        color: ColorManager.first,
                        child: Column(children: [
                          ListTile(
                            title: Text("Email",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: ColorManager.second,
                                  fontSize: 25,
                                )),
                            subtitle: Text(state.user.email??"No Email",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.second,
                                  fontSize: 20,
                                )),
                            leading: Icon(
                              Icons.email_outlined,
                              color: ColorManager.second,
                              size: 30,
                            ),
                          ),
                        ])),
                    Card(
                        color: ColorManager.first,
                        child: Column(children: [
                          ListTile(

                            title: Text("Address",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  color: ColorManager.second,
                                  fontSize: 25,
                                )),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit,color: Colors.white,),
                              onPressed: () {
                               showDialog(
                                   context: context,
                                   builder: (context) {
                                     return AlertDialog(
                                       title: const Text('Edit Address'),
                                       content: Form(
                                         key: formKey,
                                         child: CustomFormField(
                                           controller:controller,
                                            hintText: 'Enter Your Address',
                                           validator: (value) {
                                             if (value!.isEmpty) {
                                               return 'Please enter an address';
                                             }else if(value.length < 5){
                                               return 'Address is too short';
                                             }else if(value.trim().isEmpty){
                                               return 'Please enter an address';
                                             }
                                             return null;
                                           },
                                         ),
                                       ),
                                       actions: <Widget>[
                                         TextButton(
                                           onPressed: () {
                                             Navigator.of(context).pop();
                                           },
                                           child: const Text('Cancel'),
                                         ),
                                         TextButton(
                                           onPressed: () {
                                             if(formKey.currentState!.validate() == false){
                                               return;
                                             }else {
                                               try{
                                               MyDataBase.updateUser(my_user.User(
                                                  id: state.user.id,
                                                  name: state.user.name,
                                                  email: state.user.email,
                                                  phoneNumber: state.user.phoneNumber,
                                                  address: controller.text,
                                               ));
                                               Navigator.of(context).pop();
                                               controller.clear();
                                               ProfileCubit.get(profileContext!).getUserFromDataBase();
                                               buildShowToast("Success");
                                             }on Exception catch(e){
                                              buildShowToast("Error: ${e.toString()}");
                                             }
                                             }

                                           },
                                           child: const Text('Save'),
                                         ),
                                       ],
                                     );
                                   },
                               );
                              },
                            ),
                            subtitle: Text(state.user.address??"No Address yet",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.second,
                                  fontSize: 20,
                                )),
                            leading: Icon(
                              Icons.location_on_outlined,
                              color: ColorManager.second,
                              size: 30,
                            ),
                          ),
                        ])),
                    Center(child: ElevatedButton(onPressed: ()async{
                      await  const FlutterSecureStorage().delete(key: 'token');
                      if(context.mounted){
                        Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginScreen.routeName,
                                (route) => false
                        );
                        //state.user.\
                        ProfileCubit.get(context).currentUser = null;
                        FirebaseAuth.instance.signOut();
                      }


                     // MyDataBase.
                    }, child: Text("Log out"))),
                    SizedBox(height: 20.h),
                     Text('History--', style: TextStyle(
                      color: ColorManager.first,
                      fontSize:25,
                      fontWeight: FontWeight.bold,
                    )
                    ),


                    BlocProvider(
                      create: (context) => HistoryCubit()..getData(),
                      child: BlocBuilder<HistoryCubit, HistoryState>(
                        builder: (context, state) {
                          if (state is HistoryLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (state is HistoryError) {
                            return Center(child: Text('${state.message}'));
                          } else if (state is HistorySuccess) {
                            return Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    // RideRequest? rideRequest;
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context,
                                            HistoryPage.routeName,
                                            arguments: state.request[index].data()
                                        );
                                      },
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.w),
                                          ),
                                          color: ColorManager.first,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'State : ${state.request[index].data().status}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15.sp,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  'Total Price : ${state.request[index].data().totalPrice}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.sp,
                                                      overflow:
                                                      TextOverflow.ellipsis),
                                                  maxLines: 1,
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  'Total Order : ${state.request[index].data().cartModelList?.length}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.sp,
                                                      overflow:
                                                      TextOverflow.ellipsis),
                                                  maxLines: 1,
                                                ),
                                                SizedBox(height: 4.h),
                                                Text(
                                                  'Time : ${state.request[index].data().time?.substring(0,19)}',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15.sp,
                                                      overflow:
                                                      TextOverflow.ellipsis),
                                                  maxLines: 1,
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) => SizedBox(
                                    height: 10.h,
                                  ),
                                  itemCount: state.request.length),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ],
                );
              }else{}
              return const Center(child: Text("known state"),);

            },
          ),
        ),
      ),
    );
  }
}
