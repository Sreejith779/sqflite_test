import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_test/features/homePage/ui/widgets/snackBar.dart';
import 'package:sqflite_test/models/dataList.dart';

import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case AddNoteActionState:
            final idState = state as AddNoteActionState;
            if (idState.id != null) {
              showSuccessSnackBar(context);
            } else {
              showErrorSnackBar(context);
            }
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case HomeLoadedState:
            final loadedState = state as HomeLoadedState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.deepPurpleAccent.shade100,
                title: const Text(
                  "Notes",
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () =>
                    showSheet(context, emailController, desController, null,null),
                backgroundColor: Colors.deepPurple,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              body: loadedState.allData.isEmpty?const Center(child: Text("No DATA Found"),):
              Container(
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,
                      childAspectRatio: 5),
                          itemCount: loadedState.allData?.length,
                          itemBuilder: (context,index){
                        return ListTile(
                          tileColor:Colors.primaries[Random().nextInt(Colors.primaries.length)].withOpacity(0.1),
                          title: Text(loadedState.allData[index].title),
                          subtitle: Text(loadedState.allData[index].description),
                          trailing:   Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(onPressed: (){
                                  showSheet(context, emailController, desController, loadedState.allData[index].id,loadedState.allData);
                                },
                                    icon: Icon(Icons.edit)),
                                IconButton(onPressed: (){},
                                    icon: Icon(Icons.delete_outline_outlined))
                              ],
                            ),
                          )
                        );
                          }),
                    )
                  ],
                ),
              ),
            );

          default:
            return SizedBox();
        }
      },
    );
  }

  void showSheet(BuildContext context, TextEditingController titleController,
      TextEditingController desController, int? id,List<DataModel>?_selectedNote) {
    if(id!=null){
      final selectedNote =_selectedNote?.firstWhere((element) => element.id==id);
      titleController.text = selectedNote!.title;
      desController.text = selectedNote!.description;

    }
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 15,
          top: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom +
              150, // Increased padding at the bottom
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: "title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide())),
              controller: titleController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  hintText: "description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide())),
              controller: desController,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  var title = titleController.text;
                  var description = desController.text;
                  if(id == null){
                    homeBloc.add(
                        HomeAddNotes(title: title, description: description));
                  }

                  titleController.clear();
                  desController.clear();
                  Navigator.pop(context);
                },
                child: Text(id == null ? "Submit" : "Update"))
          ],
        ),
      ),
    );
  }
}
