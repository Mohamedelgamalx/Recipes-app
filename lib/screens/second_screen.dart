import 'package:flutter/material.dart';
import 'home.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

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
          IconButton(onPressed: () {},
            icon: const Icon(Icons.favorite_border,
              color: Color(0xff287c6d),
              size: 30,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            color: Colors.cyan,
            width: double.infinity,
            height: 250,
            child: const Center(child: Text('hi')),
          ),
          const SizedBox(height: 30,),
          const Text('hi',style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xff287c6d),
          ),)
        ],
      ),
    );
  }
}
