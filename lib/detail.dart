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
                backgroundColor: Colors.grey.shade500,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    if (snapshot.data!.id > 1) {
                      setState(() {
                        futurePokemon = fetchPokemon(
                            "https://pokeapi.co/api/v2/pokemon/${snapshot.data!.id - 1}");
                      });
                    }
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                title: Container(
                    alignment: Alignment.center,
                    child: Text(snapshot.data!.id.toString())),
                actions: [
                  IconButton(
                    onPressed: () {
                      if (snapshot.data!.id < 1126) {
                        setState(() {
                          futurePokemon = fetchPokemon(
                              "https://pokeapi.co/api/v2/pokemon/${snapshot.data!.id + 1}");
                        });
                      }
                    },
                    icon: const Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              body: Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ListView(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 20),
                          alignment: Alignment.center,
                          child: Text(
                            snapshot.data!.name[0].toUpperCase() +
                                snapshot.data!.name.substring(1),
                            style: const TextStyle(fontSize: 25),
                          )),
                      Image.network(
                          "https://assets.pokemon.com/assets/cms2/img/pokedex/full/${(snapshot.data!.id).toString().padLeft(3, '0')}.png"), // todo limit 905
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Height",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  snapshot.data!.height.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Weight",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  snapshot.data!.weight.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Abilities",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  getAbilities(snapshot.data!.abilities),
                                  style: const TextStyle(fontSize: 20),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Base Exp",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                                Text(
                                  snapshot.data!.baseExperience.toString(),
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Type",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      Text(
                        getTypes(snapshot.data!.types),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  )));
        } else if (snapshot.hasError) {
          return AlertDialog(
            content:
                const Text("Pokemon not found. Check your input for mistypes."),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  String getAbilities(List<Ability> abilities) {
    String result = "";
    for (int i = 0; i < abilities.length; i++) {
      result += abilities[i].ability.name.toString()[0].toUpperCase() +
          abilities[i].ability.name.toString().substring(1);
      if (i < abilities.length - 1) {
        result += ", ";
      }
    }
    return result;
  }

  String getTypes(List<Type> types) {
    String result = "";
    for (int i = 0; i < types.length; i++) {
      result += types[i].type.name.toString()[0].toUpperCase() +
          types[i].type.name.toString().substring(1);
      if (i < types.length - 1) {
        result += ", ";
      }
    }
    return result;
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
