import 'package:flutter/material.dart';
//import 'package:recipe/pages/RecipeAdd.dart';


class MyRecipesPage extends StatefulWidget {
  const MyRecipesPage({super.key});

  @override
  _MyRecipesPageState createState() => _MyRecipesPageState();
}

class _MyRecipesPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Column(children: [
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recipe name: ", style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),),
                ],
              ),
            ),
          )
        ],),
      ),

      floatingActionButton: FloatingActionButton(onPressed:(){
       // Navigator.push(context, MaterialPageRoute(builder: (context)=> RecipeAdd()));
      },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[200],
      ),
    );
  }
}
