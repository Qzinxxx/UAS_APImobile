import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/anime_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Anime> list = [];

  Future<List<Anime>> fetchData() async {
    var url = Uri.parse('https://katanime.vercel.app/api/getrandom');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed =
          jsonDecode(response.body)['result'].cast<Map<String, dynamic>>();
      List<Anime> anime =
          parsed.map<Anime>((json) => Anime.fromJson(json)).toList();
      return anime;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
    }
  }

  getData() async {
    List<Anime> anime = await fetchData();
    setState(() {
      list = anime;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        hintColor: Color.fromARGB(255, 14, 7, 50),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          headline6: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          headline4: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      home: Scaffold(
        appBar: null, // Hilangkan AppBar
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              if (list.isNotEmpty)
                AnimeCardList(animes: list)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getData();
          },
          child: const Icon(Icons.refresh),
          backgroundColor: const Color.fromARGB(255, 61, 2, 238),
        ),
      ),
    );
  }
}

class AnimeCardList extends StatelessWidget {
  final List<Anime> animes;

  AnimeCardList({required this.animes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: animes
          .map(
            (anime) => Card(
              margin: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      anime.indo,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Character: ${anime.character}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Anime: ${anime.anime}',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
