import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class WaterFall extends StatefulWidget {
  const WaterFall({super.key,  required this.title});
  final String title;
  @override
  State<WaterFall> createState() => _water_fallState();

}

class _water_fallState extends State<WaterFall> {
    Widget generateContainerList() {
          return Container(
            alignment: Alignment.topCenter,
            width: 300,
            height: (Random.secure().nextInt(200) + 100).toDouble(),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),

            decoration: BoxDecoration(
              color: Color.fromARGB(255, Random.secure().nextInt(255), Random.secure().nextInt(255), Random.secure().nextInt(255)),

              // borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                color: Colors.red,
                width: 1,
              ),
            ),
            child: FractionallySizedBox(
              heightFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, Random.secure().nextInt(255), Random.secure().nextInt(255), Random.secure().nextInt(255)),
                ),
              ),

            )
            // child: CachedNetworkImage(
            //   imageUrl: 'https://www.dmoe.cc/random.php',
            //   placeholder: (context, url) => const CircularProgressIndicator(),
            //   errorWidget: (context, url, error) => const Icon(Icons.error),
            // ),
          );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            FractionallySizedBox(
              widthFactor: 0.5,
              child: Column(
                  children: List.generate(10, (index) => generateContainerList())
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.5,
              child: Column(
                  children: List.generate(10, (index) => generateContainerList())
              ),
            ),
          ]
      )
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '商城',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: '学习',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          print(index);
        },
      )
    );
  }
}
