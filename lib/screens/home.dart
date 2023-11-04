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

  int selectedIndex = 1;

  var url = Uri.parse('https://api.spoonacular.com/recipes/random?apiKey=8c5c67f1ada4419ebd242d23d347adf4&number=10');
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
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x54000000),
                  spreadRadius: 1,
                  blurRadius: 70,
                )
              ]
          ),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
                topLeft: Radius.circular(40),
              ),
              child: BottomNavigationBar(
                iconSize: 30,
                currentIndex: selectedIndex,
                onTap: (index){
                  setState(() {
                    selectedIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: '1'),
                  BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: '2'),
                  BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: '3'),
                  BottomNavigationBarItem(icon: Icon(Icons.error_outline), label: '4'),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: '5'),
                ],
                unselectedItemColor: Colors.black,
                selectedItemColor: const Color(0xff287c6d),
                showSelectedLabels: false,
                showUnselectedLabels: false,
              ),
            ),
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
                          MaterialPageRoute(builder: (context) => SecondScreen(
                            id: snapshot.data![index].id,
                          )),
                        );
                      },
                      child: SingleChildScrollView(
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