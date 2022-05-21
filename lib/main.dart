import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_mobile/detail.dart';
import 'package:pokedex_mobile/main_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 1;
  late TextEditingController search;
  late Future<ApiResultModel> futureResults;

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    futureResults = fetchApiResultModel(
        'https://pokeapi.co/api/v2/pokemon?limit=10&offset=0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 300,
          child: TextField(
            controller: search,
            decoration: const InputDecoration(label: Text("Name or Number")),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) {
                  return Detail(
                    url: searchPokemon(search.text),
                  );
                })), // todo validate input
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: buildGrid(futureResults),
    );
  }

  Widget buildGrid(future) {
    return FutureBuilder<ApiResultModel>(
      future: futureResults,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              children: [
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: counter * 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Detail(
                          url: "https://pokeapi.co/api/v2/pokemon/${index + 1}"
                        );
                      })),
                      child: Column(children: [
                        Expanded(
                            child: Image.network(
                                "https://assets.pokemon.com/assets/cms2/img/pokedex/full/${(index + 1).toString().padLeft(3, '0')}.png")), // todo limit 905
                        Text(snapshot.data!.results[index].name),
                      ]),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    counter++;
                    futureResults = fetchApiResultModel(
                        'https://pokeapi.co/api/v2/pokemon?limit=${counter * 10}&offset=0');
                    setState(() {
                      buildGrid(futureResults);
                    });
                  },
                  child: Text("Load more Pokemon"),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("ERROR: ${snapshot.error}"));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  searchPokemon(String query) {
    int? num = int.tryParse(query);
    if (num == null) {
      return "https://pokeapi.co/api/v2/pokemon/$query";
    } else {
      return "https://pokeapi.co/api/v2/pokemon/$num";
    }
  }
}

Future<ApiResultModel> fetchApiResultModel(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return apiResultModelFromJson(response.body);
  } else {
    throw Exception('Failed to load results');
  }
}
