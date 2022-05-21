import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_mobile/detail_data.dart';

class Detail extends StatefulWidget {
  const Detail({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  late Future<Pokemon> futurePokemon;

  @override
  void initState() {
    super.initState();
    futurePokemon = fetchPokemon(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Pokemon>(
      future: futurePokemon,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(onPressed: () {
                  if (snapshot.data!.id > 1) {
                    setState(() {
                      futurePokemon = fetchPokemon("https://pokeapi.co/api/v2/pokemon/${snapshot.data!.id - 1}");
                    });
                  }
                },
                  icon: const Icon(Icons.arrow_back),
                ),
                title: Text(snapshot.data!.id.toString()),
                actions: [
                  IconButton(onPressed: () {
                    setState(() {
                      futurePokemon = fetchPokemon("https://pokeapi.co/api/v2/pokemon/${snapshot.data!.id + 1}");
                    });
                  },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  Text(snapshot.data!.name),
                  Image.network(
                      "https://assets.pokemon.com/assets/cms2/img/pokedex/full/${(snapshot.data!.id).toString().padLeft(3, '0')}.png"), // todo limit 905
                  Row(
                    children: [
                      Column(
                        children: [
                          Text("Height"),
                          Text(snapshot.data!.height.toString()),
                          Text("Weight"),
                          Text(snapshot.data!.weight.toString()),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Abilities"),
                          Text(snapshot.data!.abilities[0].ability.name),
                        ],
                      ),
                    ],
                  ),
                  Text("Type"),
                  Text( snapshot.data!.types[0].type.name), // todo more types
                ],
              ));
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Future<Pokemon> fetchPokemon(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return pokemonFromJson(response.body);
  } else {
    throw Exception('Failed to load Pokemon');
  }
}
