import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/components/components.dart';
import 'package:noteapp/cubit/cubit.dart';
import 'package:noteapp/cubit/states.dart';
import 'package:noteapp/modules/homescreen.dart';
import 'package:noteapp/modules/signup.dart';
import 'package:noteapp/network/const.dart';
import 'package:noteapp/network/local.dart';

class SignIn extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Notes App",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 43,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        textFormFiled(
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "please Enter ur Email";
                            }
                            return null;
                          },
                          controller: email,
                          hint: "Enter Ur Email",
                          icon: Icons.mail,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        textFormFiled(
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "please Enter ur Pass";
                              }
                              return null;
                            },
                            controller: pass,
                            obscure: true,
                            hint: "Enter Ur Pass",
                            icon: Icons.password),
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
                              text: "Sign in",
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.authSignIn(
                                      context: context,
                                      widget: HomeScreen(),
                                      email: email.text,
                                      password: pass.text);
                                }
                              }),
                        ),
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
                              text: "Sign up",
                              function: () {
                                navigator(context: context, widget: SignUp());
                              }),
                        ),
                      ],
                    ),
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
