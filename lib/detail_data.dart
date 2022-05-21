import 'dart:convert';

Pokemon pokemonFromJson(String str) => Pokemon.fromJson(json.decode(str));

String pokemonToJson(Pokemon data) => json.encode(data.toJson());

class Pokemon {
  Pokemon({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.isDefault,
    required this.order,
    required this.weight,
    required this.abilities,
    required this.forms,
    required this.gameIndices,
    required this.heldItems,
    required this.locationAreaEncounters,
    required this.moves,
    required this.species,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.pastTypes,
  });

  int id;
  String name;
  int baseExperience;
  int height;
  bool isDefault;
  int order;
  int weight;
  List<Ability> abilities;
  List<Species> forms;
  List<GameIndex> gameIndices;
  List<HeldItem> heldItems;
  String locationAreaEncounters;
  List<Move> moves;
  Species species;
  Sprites sprites;
  List<Stat> stats;
  List<Type> types;
  List<PastType> pastTypes;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
    id: json["id"],
    name: json["name"],
    baseExperience: json["base_experience"],
    height: json["height"],
    isDefault: json["is_default"],
    order: json["order"],
    weight: json["weight"],
    abilities: List<Ability>.from(json["abilities"].map((x) => Ability.fromJson(x))),
    forms: List<Species>.from(json["forms"].map((x) => Species.fromJson(x))),
    gameIndices: List<GameIndex>.from(json["game_indices"].map((x) => GameIndex.fromJson(x))),
    heldItems: List<HeldItem>.from(json["held_items"].map((x) => HeldItem.fromJson(x))),
    locationAreaEncounters: json["location_area_encounters"],
    moves: List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
    species: Species.fromJson(json["species"]),
    sprites: Sprites.fromJson(json["sprites"]),
    stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
    types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
    pastTypes: List<PastType>.from(json["past_types"].map((x) => PastType.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "base_experience": baseExperience,
    "height": height,
    "is_default": isDefault,
    "order": order,
    "weight": weight,
    "abilities": List<dynamic>.from(abilities.map((x) => x.toJson())),
    "forms": List<dynamic>.from(forms.map((x) => x.toJson())),
    "game_indices": List<dynamic>.from(gameIndices.map((x) => x.toJson())),
    "held_items": List<dynamic>.from(heldItems.map((x) => x.toJson())),
    "location_area_encounters": locationAreaEncounters,
    "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
    "species": species.toJson(),
    "sprites": sprites.toJson(),
    "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
    "types": List<dynamic>.from(types.map((x) => x.toJson())),
    "past_types": List<dynamic>.from(pastTypes.map((x) => x.toJson())),
  };
}

class Ability {
  Ability({
    required this.isHidden,
    required this.slot,
    required this.ability,
  });

  bool isHidden;
  int slot;
  Species ability;

  factory Ability.fromJson(Map<String, dynamic> json) => Ability(
    isHidden: json["is_hidden"],
    slot: json["slot"],
    ability: Species.fromJson(json["ability"]),
  );

  Map<String, dynamic> toJson() => {
    "is_hidden": isHidden,
    "slot": slot,
    "ability": ability.toJson(),
  };
}

class Species {
  Species({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Species.fromJson(Map<String, dynamic> json) => Species(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}

class GameIndex {
  GameIndex({
    required this.gameIndex,
    required this.version,
  });

  int gameIndex;
  Species version;

  factory GameIndex.fromJson(Map<String, dynamic> json) => GameIndex(
    gameIndex: json["game_index"],
    version: Species.fromJson(json["version"]),
  );

  Map<String, dynamic> toJson() => {
    "game_index": gameIndex,
    "version": version.toJson(),
  };
}

class HeldItem {
  HeldItem({
    required this.item,
    required this.versionDetails,
  });

  Species item;
  List<VersionDetail> versionDetails;

  factory HeldItem.fromJson(Map<String, dynamic> json) => HeldItem(
    item: Species.fromJson(json["item"]),
    versionDetails: List<VersionDetail>.from(json["version_details"].map((x) => VersionDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "item": item.toJson(),
    "version_details": List<dynamic>.from(versionDetails.map((x) => x.toJson())),
  };
}

class VersionDetail {
  VersionDetail({
    required this.rarity,
    required this.version,
  });

  int rarity;
  Species version;

  factory VersionDetail.fromJson(Map<String, dynamic> json) => VersionDetail(
    rarity: json["rarity"],
    version: Species.fromJson(json["version"]),
  );

  Map<String, dynamic> toJson() => {
    "rarity": rarity,
    "version": version.toJson(),
  };
}

class Move {
  Move({
    required this.move,
    required this.versionGroupDetails,
  });

  Species move;
  List<VersionGroupDetail> versionGroupDetails;

  factory Move.fromJson(Map<String, dynamic> json) => Move(
    move: Species.fromJson(json["move"]),
    versionGroupDetails: List<VersionGroupDetail>.from(json["version_group_details"].map((x) => VersionGroupDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "move": move.toJson(),
    "version_group_details": List<dynamic>.from(versionGroupDetails.map((x) => x.toJson())),
  };
}

class VersionGroupDetail {
  VersionGroupDetail({
    required this.levelLearnedAt,
    required this.versionGroup,
    required this.moveLearnMethod,
  });

  int levelLearnedAt;
  Species versionGroup;
  Species moveLearnMethod;

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) => VersionGroupDetail(
    levelLearnedAt: json["level_learned_at"],
    versionGroup: Species.fromJson(json["version_group"]),
    moveLearnMethod: Species.fromJson(json["move_learn_method"]),
  );

  Map<String, dynamic> toJson() => {
    "level_learned_at": levelLearnedAt,
    "version_group": versionGroup.toJson(),
    "move_learn_method": moveLearnMethod.toJson(),
  };
}

class PastType {
  PastType({
    required this.generation,
    required this.types,
  });

  Species generation;
  List<Type> types;

  factory PastType.fromJson(Map<String, dynamic> json) => PastType(
    generation: Species.fromJson(json["generation"]),
    types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "generation": generation.toJson(),
    "types": List<dynamic>.from(types.map((x) => x.toJson())),
  };
}

class Type {
  Type({
    required this.slot,
    required this.type,
  });

  int slot;
  Species type;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    slot: json["slot"],
    type: Species.fromJson(json["type"]),
  );

  Map<String, dynamic> toJson() => {
    "slot": slot,
    "type": type.toJson(),
  };
}

class GenerationV {
  GenerationV({
    required this.blackWhite,
  });

  Sprites blackWhite;

  factory GenerationV.fromJson(Map<String, dynamic> json) => GenerationV(
    blackWhite: Sprites.fromJson(json["black-white"]),
  );

  Map<String, dynamic> toJson() => {
    "black-white": blackWhite.toJson(),
  };
}

class GenerationIv {
  GenerationIv({
    required this.diamondPearl,
    required this.heartgoldSoulsilver,
    required this.platinum,
  });

  Sprites diamondPearl;
  Sprites heartgoldSoulsilver;
  Sprites platinum;

  factory GenerationIv.fromJson(Map<String, dynamic> json) => GenerationIv(
    diamondPearl: Sprites.fromJson(json["diamond-pearl"]),
    heartgoldSoulsilver: Sprites.fromJson(json["heartgold-soulsilver"]),
    platinum: Sprites.fromJson(json["platinum"]),
  );

  Map<String, dynamic> toJson() => {
    "diamond-pearl": diamondPearl.toJson(),
    "heartgold-soulsilver": heartgoldSoulsilver.toJson(),
    "platinum": platinum.toJson(),
  };
}

class Versions {
  Versions({
    required this.generationI,
    required this.generationIi,
    required this.generationIii,
    required this.generationIv,
    required this.generationV,
    required this.generationVi,
    required this.generationVii,
    required this.generationViii,
  });

  GenerationI generationI;
  GenerationIi generationIi;
  GenerationIii generationIii;
  GenerationIv generationIv;
  GenerationV generationV;
  Map<String, Home> generationVi;
  GenerationVii generationVii;
  GenerationViii generationViii;

  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
    generationI: GenerationI.fromJson(json["generation-i"]),
    generationIi: GenerationIi.fromJson(json["generation-ii"]),
    generationIii: GenerationIii.fromJson(json["generation-iii"]),
    generationIv: GenerationIv.fromJson(json["generation-iv"]),
    generationV: GenerationV.fromJson(json["generation-v"]),
    generationVi: Map.from(json["generation-vi"]).map((k, v) => MapEntry<String, Home>(k, Home.fromJson(v))),
    generationVii: GenerationVii.fromJson(json["generation-vii"]),
    generationViii: GenerationViii.fromJson(json["generation-viii"]),
  );

  Map<String, dynamic> toJson() => {
    "generation-i": generationI.toJson(),
    "generation-ii": generationIi.toJson(),
    "generation-iii": generationIii.toJson(),
    "generation-iv": generationIv.toJson(),
    "generation-v": generationV.toJson(),
    "generation-vi": Map.from(generationVi).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "generation-vii": generationVii.toJson(),
    "generation-viii": generationViii.toJson(),
  };
}

class Sprites {
  Sprites({
    required this.backDefault,
    required this.backFemale,
    required this.backShiny,
    required this.backShinyFemale,
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
    // required this.other,
    // required this.versions,
    // required this.animated,
  });

  String backDefault;
  dynamic backFemale;
  String backShiny;
  dynamic backShinyFemale;
  String frontDefault;
  dynamic frontFemale;
  String frontShiny;
  dynamic frontShinyFemale;
  // Other other;
  // Versions versions;
  // Sprites animated;

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
    backDefault: json["back_default"],
    backFemale: json["back_female"],
    backShiny: json["back_shiny"],
    backShinyFemale: json["back_shiny_female"],
    frontDefault: json["front_default"],
    frontFemale: json["front_female"],
    frontShiny: json["front_shiny"],
    frontShinyFemale: json["front_shiny_female"],
    // other: json["other"] == null ? null : Other.fromJson(json["other"]),
    // versions: json["versions"] == null ? null : Versions.fromJson(json["versions"]),
    // animated: json["animated"] == null ? null : Sprites.fromJson(json["animated"]),
  );

  Map<String, dynamic> toJson() => {
    "back_default": backDefault,
    "back_female": backFemale,
    "back_shiny": backShiny,
    "back_shiny_female": backShinyFemale,
    "front_default": frontDefault,
    "front_female": frontFemale,
    "front_shiny": frontShiny,
    "front_shiny_female": frontShinyFemale,
    // "other": other == null ? null : other.toJson(),
    // "versions": versions == null ? null : versions.toJson(),
    // "animated": animated == null ? null : animated.toJson(),
  };
}

class GenerationI {
  GenerationI({
    required this.redBlue,
    required this.yellow,
  });

  RedBlue redBlue;
  RedBlue yellow;

  factory GenerationI.fromJson(Map<String, dynamic> json) => GenerationI(
    redBlue: RedBlue.fromJson(json["red-blue"]),
    yellow: RedBlue.fromJson(json["yellow"]),
  );

  Map<String, dynamic> toJson() => {
    "red-blue": redBlue.toJson(),
    "yellow": yellow.toJson(),
  };
}

class RedBlue {
  RedBlue({
    required this.backDefault,
    required this.backGray,
    required this.frontDefault,
    required this.frontGray,
  });

  String backDefault;
  String backGray;
  String frontDefault;
  String frontGray;

  factory RedBlue.fromJson(Map<String, dynamic> json) => RedBlue(
    backDefault: json["back_default"],
    backGray: json["back_gray"],
    frontDefault: json["front_default"],
    frontGray: json["front_gray"],
  );

  Map<String, dynamic> toJson() => {
    "back_default": backDefault,
    "back_gray": backGray,
    "front_default": frontDefault,
    "front_gray": frontGray,
  };
}

class GenerationIi {
  GenerationIi({
    required this.crystal,
    required this.gold,
    required this.silver,
  });

  Crystal crystal;
  Crystal gold;
  Crystal silver;

  factory GenerationIi.fromJson(Map<String, dynamic> json) => GenerationIi(
    crystal: Crystal.fromJson(json["crystal"]),
    gold: Crystal.fromJson(json["gold"]),
    silver: Crystal.fromJson(json["silver"]),
  );

  Map<String, dynamic> toJson() => {
    "crystal": crystal.toJson(),
    "gold": gold.toJson(),
    "silver": silver.toJson(),
  };
}

class Crystal {
  Crystal({
    required this.backDefault,
    required this.backShiny,
    required this.frontDefault,
    required this.frontShiny,
  });

  String backDefault;
  String backShiny;
  String frontDefault;
  String frontShiny;

  factory Crystal.fromJson(Map<String, dynamic> json) => Crystal(
    backDefault: json["back_default"],
    backShiny: json["back_shiny"],
    frontDefault: json["front_default"],
    frontShiny: json["front_shiny"],
  );

  Map<String, dynamic> toJson() => {
    "back_default": backDefault,
    "back_shiny": backShiny,
    "front_default": frontDefault,
    "front_shiny": frontShiny,
  };
}

class GenerationIii {
  GenerationIii({
    required this.emerald,
    required this.fireredLeafgreen,
    required this.rubySapphire,
  });

  Emerald emerald;
  Crystal fireredLeafgreen;
  Crystal rubySapphire;

  factory GenerationIii.fromJson(Map<String, dynamic> json) => GenerationIii(
    emerald: Emerald.fromJson(json["emerald"]),
    fireredLeafgreen: Crystal.fromJson(json["firered-leafgreen"]),
    rubySapphire: Crystal.fromJson(json["ruby-sapphire"]),
  );

  Map<String, dynamic> toJson() => {
    "emerald": emerald.toJson(),
    "firered-leafgreen": fireredLeafgreen.toJson(),
    "ruby-sapphire": rubySapphire.toJson(),
  };
}

class Emerald {
  Emerald({
    required this.frontDefault,
    required this.frontShiny,
  });

  String frontDefault;
  String frontShiny;

  factory Emerald.fromJson(Map<String, dynamic> json) => Emerald(
    frontDefault: json["front_default"],
    frontShiny: json["front_shiny"],
  );

  Map<String, dynamic> toJson() => {
    "front_default": frontDefault,
    "front_shiny": frontShiny,
  };
}

class Home {
  Home({
    required this.frontDefault,
    required this.frontFemale,
    required this.frontShiny,
    required this.frontShinyFemale,
  });

  String frontDefault;
  dynamic frontFemale;
  String frontShiny;
  dynamic frontShinyFemale;

  factory Home.fromJson(Map<String, dynamic> json) => Home(
    frontDefault: json["front_default"],
    frontFemale: json["front_female"],
    frontShiny: json["front_shiny"],
    frontShinyFemale: json["front_shiny_female"],
  );

  Map<String, dynamic> toJson() => {
    "front_default": frontDefault,
    "front_female": frontFemale,
    "front_shiny": frontShiny,
    "front_shiny_female": frontShinyFemale,
  };
}

class GenerationVii {
  GenerationVii({
    required this.icons,
    required this.ultraSunUltraMoon,
  });

  DreamWorld icons;
  Home ultraSunUltraMoon;

  factory GenerationVii.fromJson(Map<String, dynamic> json) => GenerationVii(
    icons: DreamWorld.fromJson(json["icons"]),
    ultraSunUltraMoon: Home.fromJson(json["ultra-sun-ultra-moon"]),
  );

  Map<String, dynamic> toJson() => {
    "icons": icons.toJson(),
    "ultra-sun-ultra-moon": ultraSunUltraMoon.toJson(),
  };
}

class DreamWorld {
  DreamWorld({
    required this.frontDefault,
    required this.frontFemale,
  });

  String frontDefault;
  dynamic frontFemale;

  factory DreamWorld.fromJson(Map<String, dynamic> json) => DreamWorld(
    frontDefault: json["front_default"],
    frontFemale: json["front_female"],
  );

  Map<String, dynamic> toJson() => {
    "front_default": frontDefault,
    "front_female": frontFemale,
  };
}

class GenerationViii {
  GenerationViii({
    required this.icons,
  });

  DreamWorld icons;

  factory GenerationViii.fromJson(Map<String, dynamic> json) => GenerationViii(
    icons: DreamWorld.fromJson(json["icons"]),
  );

  Map<String, dynamic> toJson() => {
    "icons": icons.toJson(),
  };
}

class Other {
  Other({
    required this.dreamWorld,
    required this.home,
    required this.officialArtwork,
  });

  DreamWorld dreamWorld;
  Home home;
  OfficialArtwork officialArtwork;

  factory Other.fromJson(Map<String, dynamic> json) => Other(
    dreamWorld: DreamWorld.fromJson(json["dream_world"]),
    home: Home.fromJson(json["home"]),
    officialArtwork: OfficialArtwork.fromJson(json["official-artwork"]),
  );

  Map<String, dynamic> toJson() => {
    "dream_world": dreamWorld.toJson(),
    "home": home.toJson(),
    "official-artwork": officialArtwork.toJson(),
  };
}

class OfficialArtwork {
  OfficialArtwork({
    required this.frontDefault,
  });

  String frontDefault;

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) => OfficialArtwork(
    frontDefault: json["front_default"],
  );

  Map<String, dynamic> toJson() => {
    "front_default": frontDefault,
  };
}

class Stat {
  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  int baseStat;
  int effort;
  Species stat;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
    baseStat: json["base_stat"],
    effort: json["effort"],
    stat: Species.fromJson(json["stat"]),
  );

  Map<String, dynamic> toJson() => {
    "base_stat": baseStat,
    "effort": effort,
    "stat": stat.toJson(),
  };
}
