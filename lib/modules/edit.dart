import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:noteapp/components/components.dart';
import 'package:noteapp/cubit/cubit.dart';
import 'package:noteapp/cubit/states.dart';
import 'package:noteapp/modules/homescreen.dart';

class Edit extends StatelessWidget {
  String doc;
  Map<String, dynamic> notes = {};

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Edit({required this.doc, required this.notes});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TextEditingController title =
            TextEditingController(text: notes["title"]);

        TextEditingController body = TextEditingController(text: notes["body"]);
        var cubit = NoteCubit.get(context);
        return Scaffold(
          body: SafeArea(
              child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textFormFiled(
                      // initial: notes["title"],
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
                      // initial: notes["body"],
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
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 24, 120, 199),
                        borderRadius: BorderRadius.circular(10)),
                    child: button(
                        text: "Submit",
                        function: () {
                          if (formkey.currentState!.validate()) {
                            cubit.update(
                                doc: doc, title: title.text, body: body.text);
                            navigator(
                                context: context, widget: const HomeScreen());
                          }
                        }),
                  )
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
