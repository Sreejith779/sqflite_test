

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
  }
  void showSheet(BuildContext context, TextEditingController emailController, TextEditingController desController, int? id) {
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
                      borderSide: BorderSide()
                  )
              ),
              controller: emailController,
            ),
            SizedBox(height: 10,),
            TextField(
              decoration: InputDecoration(
                  hintText: "description",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide()
                  )
              ),
              controller: desController,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  // Add your submit functionality here
                },
                child: Text(id==null?"Submit":"Update")
            )
          ],
        ),
      ),
    );
  }

}
