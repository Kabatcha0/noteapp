import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/components/components.dart';
import 'package:noteapp/cubit/cubit.dart';
import 'package:noteapp/cubit/states.dart';
import 'package:noteapp/modules/homescreen.dart';
import 'package:noteapp/network/const.dart';
import 'package:noteapp/network/local.dart';

class SignUp extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController gender = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteStates>(
      listener: (context, state) {},
      builder: (context, state) {
        getTheData = false;

        var cubit = NoteCubit.get(context);
        return Scaffold(
          body: SafeArea(
              child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text(
                        "Notes App",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      textFormFiled(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "please enter your email";
                            }
                            return null;
                          },
                          controller: email,
                          hint: "Enter Ur Email",
                          icon: Icons.mail),
                      const SizedBox(
                        height: 12,
                      ),
                      textFormFiled(
                          obscure: true,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "please enter your Pass";
                            }
                            if (v.characters.length < 6) {
                              return "pass must be greater than 6 ";
                            }
                            return null;
                          },
                          controller: pass,
                          hint: "Enter Ur Pass",
                          icon: Icons.password),
                      const SizedBox(
                        height: 12,
                      ),
                      textFormFiled(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "please enter your User";
                            }
                            if (v.characters.length < 8) {
                              return "username must greater than 8";
                            }
                            return null;
                          },
                          controller: username,
                          hint: "Enter Ur User",
                          icon: Icons.person),
                      const SizedBox(
                        height: 12,
                      ),
                      textFormFiled(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "please enter your Gender";
                            }
                            return null;
                          },
                          controller: gender,
                          hint: "Enter Ur Gender",
                          icon: Icons.boy),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 24, 120, 199),
                            borderRadius: BorderRadius.circular(10)),
                        width: double.infinity,
                        child: button(
                            text: "Sign Up",
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.authCreate(
                                    name: username.text,
                                    context: context,
                                    widget: HomeScreen(),
                                    email: email.text,
                                    password: pass.text,
                                    gender: gender.text);
                                navigator(
                                    context: context, widget: HomeScreen());
                              }
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
