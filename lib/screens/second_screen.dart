import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'home.dart';

class SecondScreen extends StatefulWidget {

  int? id;

  SecondScreen({super.key, this.id});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  bool isChecked = false;

  _toggleFavorite(){
    setState(() {
      if (isChecked) {
        isChecked = false;
      } else {
        isChecked = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future fetchRecipes() async {
    var url = Uri.parse('https://api.spoonacular.com/recipes/${widget.id}/information?apiKey=8c5c67f1ada4419ebd242d23d347adf4');
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('cant load the recipe');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        leading: IconButton(onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Home()),
          );
        },
          icon: const Icon(Icons.arrow_back_ios_outlined,
            color: Color(0xff287c6d),
            size: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: (isChecked
                ? const Icon(Icons.favorite,size: 30, color: Color(0xff287c6d),)
                : const Icon(Icons.favorite_outline,size: 30, color: Color(0xff287c6d),)
            ),
          ),

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: FutureBuilder(
              future: fetchRecipes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 250,
                        child: Image.network('${snapshot.data!['image']}'),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Text('${snapshot.data!['title']}',style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff287c6d),
                        ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 120, height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12)
                            ),
                            child: const Center(child: Text('Easy' , style: TextStyle(
                              fontSize: 15
                            ),)),
                          ),
                          Container(
                            width: 120, height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.alarm, color: Color(0xff287c6d),),
                                Text('${snapshot.data!['readyInMinutes']} mins')
                              ],
                            ),
                          ),
                          Container(
                            width: 120, height: 60,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12)
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('15', style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff287c6d)
                                )),
                                Text('Ingredients', style: TextStyle(
                                    fontSize: 15,
                                )
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Text(snapshot.data!['instructions']),
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator(
                  color: Color(0xff287c6d),
                ));
                }
            ),
          ),
        ),
      )
    );
  }
}