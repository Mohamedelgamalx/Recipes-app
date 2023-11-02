import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_recipe/screens/second_screen.dart';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

List<Recipe> recipes = [];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var url = Uri.parse('https://api.spoonacular.com/recipes/random?apiKey=89bc7b285b1449f49d0c70d3bd26e4cf&number=10');
  Future<List<Recipe>> fetchRecipes() async {
    http.Response response = await http.get(url);
    for(var r in json.decode(response.body)['recipes']){
      recipes.add(Recipe.fromJson(r));
    }
    if (response.statusCode == 200) {
      return recipes;
    } else {
      throw Exception('cant load the recipe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        leading: const Icon(Icons.menu,
          color: Color(0xff287c6d),
          size: 30,
        ),
        title: const Text('Home', style: TextStyle(
            color: Color(0xff287c6d),
            fontSize: 25,
            fontWeight: FontWeight.bold
        ),
        ),
        actions: [
          IconButton(onPressed: () {},
            icon: const Icon(Icons.search,
              color: Color(0xff287c6d),
              size: 30,
            ),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<List<Recipe>>(
          future: fetchRecipes(),
          builder: (context,snapshot) {
            if(snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.all(8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white70
                        ),
                        onPressed: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const SecondScreen()),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(snapshot.data![index].image),
                            const SizedBox(height: 7,),
                            Text(snapshot.data![index].title, style: const TextStyle(
                              color: Colors.black
                            ),)
                          ],
                        ),
                      ),
                    );
              },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator(
              color: Color(0xff287c6d),
            );
          },
        ),
      ),
    );
  }
}