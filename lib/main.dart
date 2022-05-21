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
        primarySwatch: Colors.blue,
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
  late Future<ApiResultModel> futureResults;

  @override
  void initState() {
    super.initState();
    futureResults = fetchApiResultModel(
        'https://pokeapi.co/api/v2/pokemon?limit=10&offset=0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon"),
      ),
      body: FutureBuilder<ApiResultModel>(
        future: futureResults,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildGrid(snapshot);
          } else if (snapshot.hasError) {
            return Center(child: Text("ERROR: ${snapshot.error}"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget buildGrid(snapshot) {
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
            itemCount: 10,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return Detail(
                    url: snapshot.data!.results[index].url,
                  );
                })),
                child: Column(children: [
                  Expanded(
                      child: Image.network(
                          "https://assets.pokemon.com/assets/cms2/img/pokedex/full/00${index + 1}.png")), // todo
                  Text(snapshot.data!.results[index].name),
                ]),
              );
            },
          ),
          TextButton(onPressed: () {}, child: Text("Load more Pokemon")),
        ],
      ),
    );
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
