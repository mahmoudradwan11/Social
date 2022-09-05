import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home/Home_layout.dart';
import 'package:social/modules/login/cubit/cubit.dart';
import 'package:social/modules/login/cubit/states.dart';
import 'package:social/modules/register/register.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/network/local/cache_helper.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener:(context,state){
          if(state is LoginSuccessState){
            CacheHelper.saveData(
                key:'uId',
                value:state.uid,
            ).then((value){
                navigateAndFinish(context,const Home());
            });
          }
        },
        builder:(context,state){
          var cubit = LoginCubit.get(context);
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
                          'LOGIN',
                          style:
                          Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Login now to communicate with friends',
                            style:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        tFF(
                          show: false,
                          controller: emailController,
                          keyboard: TextInputType.emailAddress,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'Email Must not be Empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        tFF(
                          show: cubit.passwordShow,
                          suffix: cubit.suffixIcon,
                          suffixPress: () {
                            cubit.changePasswordIcon();
                          },
                          controller: passwordController,
                          keyboard: TextInputType.visiblePassword,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'Password is to short';
                            }
                            return null;
                          },
                          label: 'password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        if(state is LoadingLogin)
                          const LinearProgressIndicator(),
                        const SizedBox(
                          height: 2,
                        ),
                        dB(
                            function: (){
                              if (formKey.currentState!.validate()) {
                                 cubit.loginUser(
                                     email: emailController.text,
                                     password: passwordController.text
                                 );
                               }
                            },
                            text: 'LOGIN',
                            isUpper: true),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an Account?'),tB(
                                text: 'Register ',
                                function: () {
                                  navigateTo(context, Register());
                                }),
                          ],
                        )
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

