import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/recipe.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late Future<Recipe> recipeData;

  @override
  initState() {
    super.initState();
    recipeData = fetchRecipes();
  }
  
  var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
  Future<Recipe> fetchRecipes() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      //print(response.body);
      return Recipe.fromJson(json.decode(response.body));
    } else {
      throw Exception('cant load the recipe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        leading: const Icon(Icons.menu,
          color: Color(0xff287c6d),
          size: 30,
        ),
        title: Row(
          children: [
            const SizedBox(width: 105,),
            const Text('Home', style: TextStyle(
              color: Color(0xff287c6d),
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),),
            const SizedBox(width: 115,),
            IconButton(onPressed: () {},
                icon: const Icon(Icons.search,
                  color: Color(0xff287c6d),
                  size: 30,
                ),
            )
          ],
        )
      ),
      body: Center(
        child: FutureBuilder<Recipe>(
          future: recipeData,
          builder: (context,snapshot) {
            if(snapshot.hasData) {
              return Text(snapshot.data!.title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}