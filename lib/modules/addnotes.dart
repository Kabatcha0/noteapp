import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:noteapp/components/components.dart';
import 'package:noteapp/cubit/cubit.dart';
import 'package:noteapp/cubit/states.dart';
import 'package:noteapp/modules/homescreen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AddNotes extends StatelessWidget {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteStates>(
      listener: (context, state) {
        if (state is NoteAddNotesLoadingState) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.noHeader,
            animType: AnimType.rightSlide,
            title: 'Loading',
          ).show();
        }
        if (state is NoteGetDataState) {
          navigator(context: context, widget: const HomeScreen());
        }
      },
      builder: (context, state) {
        var cubit = NoteCubit.get(context);
        return Scaffold(
          body: SafeArea(
              child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textFormFiled(
                      helper: "title",
                      icon: Icons.text_fields,
                      controller: title,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Write the title";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  textFormFiled(
                      maxLines: 5,
                      helper: "body",
                      icon: Icons.text_fields,
                      controller: body,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Write the body";
                        }
                        return null;
                      }),
                  const SizedBox(
                    height: 15,
                  ),
                  if (cubit.file != null)
                    const Icon(
                      Icons.done_all_rounded,
                      color: Colors.white,
                    ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 24, 120, 199),
                        borderRadius: BorderRadius.circular(10)),
                    child: button(
                        text: "Submit",
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.addNotes(
                                title: title.text,
                                body: body.text,
                                date: Jiffy().dateTime);
                          }
                        }),
                  )
                ],
              ),
            ),
          )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              cubit.imagePick(context: context);
            },
            child: const Icon(Icons.photo),
          ),
        );
      },
    );
  }
}
