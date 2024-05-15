

 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_test/features/homePage/ui/widgets/snackBar.dart';

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
    return BlocConsumer<HomeBloc,HomeState>(
      bloc: homeBloc,
  listenWhen: (previous,current)=>current is HomeActionState,
  buildWhen: (previous,current)=>current is! HomeActionState,
  listener: (context, state) {
     switch(state.runtimeType){
       case AddNoteActionState:
         final idState = state as AddNoteActionState;
         if(idState.id!=null){
           showSuccessSnackBar(context);
         }else{
           showErrorSnackBar(context);
         }
     }
  },
  builder: (context, state) {
switch(state.runtimeType){
  case HomeLoadingState:
    return const Center(
      child: CircularProgressIndicator(),
    );
  case HomeLoadedState:
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent.shade100,
        title: const Text(
          "Notes",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showSheet(context,emailController,desController,null),
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );

  default:
    return SizedBox();
}

  },
);
  }
  void showSheet(BuildContext context, TextEditingController titleController, TextEditingController desController, int? id) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 15,
          top: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 150, // Increased padding at the bottom
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                  hintText: "title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide()
                  )
              ),
              controller: titleController,
            ),
            const SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                  hintText: "description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide()
                  )
              ),
              controller: desController,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
          var title = titleController.text;
          var description = desController.text;
          homeBloc.add(HomeAddNotes(title: title, description: description));
          titleController.clear();
          desController.clear();
          Navigator.pop(context);

                } ,
                child: Text(id==null?"Submit":"Update")
            )
          ],
        ),
      ),
    );
  }

}
