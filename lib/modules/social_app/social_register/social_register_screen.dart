import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/socialapp/cubit/cubit.dart';
import '../../../layout/socialapp/sociallayout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

// ignore: must_be_immutable
class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();


  SocialRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is SocialCreateUserSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
                value:state.uId,
            ).then((value) async {
              SocialCubit.get(context).getUserData(uId);

              showToast(
                text: 'Welcome in Social App',
                state: ToastStates.SUCCESS,
              );
              navigateAndFinish(
                context,
                SocialLayout(0),

              );
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 38,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          context: context,
                          type: TextInputType.name,
                          keyboardType: TextInputType.name,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Name must not be Empty !!';
                            }
                            return null;
                          },
                          controller: nameController,
                          prefix: Icons.person,
                          labelText: "User Name",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          context: context,
                          type: TextInputType.emailAddress,
                          keyboardType: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Email must not be Empty !!';
                            }
                            return null;
                          },
                          controller: emailController,
                          prefix: Icons.email_outlined,
                          labelText: "Email address",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          context: context,
                          type: TextInputType.visiblePassword,
                          keyboardType: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'password is too short !!';
                            }
                            return null;
                          },
                          controller: passwordController,
                          suffix: SocialRegisterCubit.get(context).suffix,
                          isPassword:
                              SocialRegisterCubit.get(context).isPassword,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                          prefix: Icons.lock_outline,
                          labelText: "Password",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          context: context,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          labelText: "Phone",
                          prefix: Icons.phone,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: defaultTextButton(
                            text: "Register",
                            style: TextStyle(color: Colors.blue),
                            isUpperCase: true,
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialRegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        if (state is SocialRegisterLoadingState)
                          LinearProgressIndicator(color: Colors.blue,),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
