import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layout/home/Home_layout.dart';
import 'package:social/modules/register/cubit/states.dart';
import 'package:social/shared/components/components.dart';
import 'cubit/cubit.dart';
class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();
    return BlocProvider(
      create:(context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener:(context,state){
          if(state is CreateUserSuccessState)
          {
            navigateAndFinish(context,const Home());
          }
        },
        builder:(context,state){
          RegisterCubit cubit = RegisterCubit.get(context);
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
                          'REGISTER',
                          style:
                          Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('Register now to communicate with friends',
                            style:
                            Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Colors.grey,
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        tFF(
                          show: false,
                          controller: nameController,
                          keyboard: TextInputType.name,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'Name Must not be Empty';
                            }
                            return null;
                          },
                          label: 'Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 15.0,
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
                          prefix: Icons.email,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        tFF(
                          show: cubit.isPassword,
                          suffix: cubit.suffix,
                          suffixPress:(){
                            cubit.changePasswordVisibility();
                          },
                          controller: passwordController,
                          keyboard: TextInputType.visiblePassword,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'Password is to short must be more than 5 letter';
                            }
                            return null;
                          },
                          label: 'password',
                          prefix: Icons.lock_outline,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        tFF(
                          show: false,
                          controller: phoneController,
                          keyboard: TextInputType.phone,
                          valid: (value) {
                            if (value.isEmpty) {
                              return 'phone Must not be Empty';
                            }
                            return null;
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        dB(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            isUpper: true
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
