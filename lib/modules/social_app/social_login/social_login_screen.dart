import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../layout/socialapp/cubit/cubit.dart';
import '../../../layout/socialapp/sociallayout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/color.dart';
import '../social_register/social_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  const SocialLoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);

          }
          if(state is SocialLoginSuccessState )
            {
              CacheHelper.saveData(
                key: 'uId',
                value:state.uId,
              ).then((value) async {
                SocialCubit.get(context).getUserData(uId);
                showToast(
                  text: 'Welcome in Social App',
                  state: ToastStates.SUCCESS,
                );
                navigateAndFinish(context, SocialLayout(0));
                SocialCubit.get(context).currentIndex = 0;


              });
            }

        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              actions: const [

              ],
            ),
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
                          'LOGIN',
                          style: TextStyle(fontSize: 38,  ),
                        ),
                        Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(fontSize: 18, color: Colors.grey ),

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
                          },
                          controller: passwordController,
                          suffix: SocialLoginCubit
                              .get(context)
                              .suffix,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              SocialLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                            }
                          },
                          // onChange: (value)
                       //    {print(value!);},
                          isPassword: SocialLoginCubit
                              .get(context)
                              .isPassword,
                          suffixPressed: () {
                            SocialLoginCubit.get(context).changePasswordVisibility();
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
                          height: 15,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: State is! SocialLoginLoadingState,
                            builder: (context) =>
                                defaultTextButton(
                                  text: "Login", style: TextStyle(color:defaultColor),
                                  isUpperCase: true,
                                  function: () {
                                    if (formKey.currentState!.validate()) {
                                      SocialLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);

                                    }
                                  },
                                ),
                            fallback: (context) => Center(child: CircularProgressIndicator()),
                          ),
                        ),
                        if(state is SocialLoginLoadingState)
                          LinearProgressIndicator(color: Colors.blue,),

                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.grey[300],
                                height: 1,
                              ),
                            ),
                            Container(

                                padding: EdgeInsets.all(8),
                                child: Text("OR Sign With",
                                 )),
                            Expanded(
                              child: Container(
                                color: Colors.grey[300],
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                              //  SocialCubit.get(context).changeMode();
                              },
                              child: CircleAvatar(
                                child:Image(image:AssetImage('assests/images/facebook_logo.png',),width: 40,height: 40,),
                                backgroundColor: Colors.white.withOpacity(0),
                              ),
                            ),
                            SizedBox(width: 50,),
                            InkWell(
                              onTap: (){
                               SocialLoginCubit.get(context).getGoogleUserCredentials();

                              },
                              child: CircleAvatar(
                                 child: state is LoginGoogleUserLoadingState?
                                 CircularProgressIndicator() :
                                Image(image:AssetImage('assests/images/Google_Logo.png',),width: 50,height: 50,),
                                backgroundColor:Colors.white.withOpacity(0),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            defaultTextButton(
                              function: () {
                                navigateTo(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                              text: 'register',
                            ),
                          ],
                        ),
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
