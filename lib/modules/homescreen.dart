import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/components/components.dart';
import 'package:noteapp/cubit/cubit.dart';
import 'package:noteapp/cubit/states.dart';
import 'package:noteapp/modules/addnotes.dart';
import 'package:noteapp/modules/signin.dart';
import 'package:noteapp/network/const.dart';
import 'package:noteapp/network/local.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteCubit, NoteStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NoteCubit.get(context);
        // cubit.onMessage();
        if (getTheData == false) {
          cubit.getData();
        }
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  CacheHelper.removeString("uid");
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                },
                icon: const Icon(Icons.exit_to_app_outlined),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      cubit.file = null;
                      navigator(context: context, widget: AddNotes());
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 25,
                    ))
              ],
              backgroundColor: Colors.black,
              title: const Text(
                "Notes App",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  // cubit.data == null
                  //     ? const Center(
                  //         child: Text(
                  //           "Empty",
                  //           style: TextStyle(
                  //               color: Colors.white,
                  //               fontSize: 25,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       )
                  //     :
                  ConditionalBuilder(
                      condition: cubit.data!.isNotEmpty
                      // state is! NoteUpdateNotesLoadingState &&
                      //     state is NoteGetDataState
                      ,
                      builder: (context) {
                        return ListView.separated(
                          itemBuilder: (context, index) => Dismissible(
                            key: UniqueKey(),
                            onDismissed: (v) {
                              cubit.deleteNote(
                                  doc: cubit.id[index],
                                  index: index,
                                  dataRemove: cubit.data!);
                            },
                            background: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 28,
                            ),
                            child: listTile(
                                doc: cubit.id[index],
                                body: cubit.data![index]["body"],
                                context: context,
                                image: cubit.data![index]["image"],
                                text: cubit.data![index]["title"],
                                notes: cubit.data![index]),
                          ),
                          itemCount: cubit.data!.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 12,
                          ),
                        );
                      },
                      fallback: (context) => const Center(
                            child: Text(
                              "Empty",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                      // const Center(
                      //       child: CircularProgressIndicator(
                      //         color: Colors.white,
                      //       ),
                      //     ))
                      ),
            ));
      },
    );
  }
}
