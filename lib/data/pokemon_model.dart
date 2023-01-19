class Pokemon {
  final int id;
  final String name;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  Pokemon({required this.id, required this.name});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final String name = json['name'];
    final String url = json['url'];
    final int id = int.parse(url.split('/')[6]);
    return Pokemon(id: id, name: name);
  }
}

class PokemonDetails {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final String description;

  PokemonDetails(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.types,
      required this.height,
      required this.weight,
      required this.description});
}

class PokemonPageResponse {
  final List<Pokemon> pokemonList;
  final bool canLoadNext;
  final bool canLoadPrev;

  PokemonPageResponse(
      {required this.pokemonList,
      required this.canLoadNext,
      required this.canLoadPrev});

  factory PokemonPageResponse.fromJson(Map<String, dynamic> json) {
    final List<Pokemon> pokemonList = (json['results'] as List)
        .map((pokemon) => Pokemon.fromJson(pokemon))
        .toList();
    final bool canLoadNext = json['next'] != null;
    final bool canLoadPrev = json['previous'] != null;

    return PokemonPageResponse(
        pokemonList: pokemonList,
        canLoadNext: canLoadNext,
        canLoadPrev: canLoadPrev);
  }
}

class PokemonInfoResponse {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;

  PokemonInfoResponse(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.types,
      required this.height,
      required this.weight});

  factory PokemonInfoResponse.fromJson(Map<String, dynamic> json) {
    final int id = json['id'];
    final String name = json['name'];
    final String imageUrl = json['sprites']['front_default'];
    final List<String> types = (json['types'] as List)
        .map((typeJson) => typeJson['type']['name'].toString())
        .toList();
    final int height = json['height'];
    final int weight = json['weight'];

    return PokemonInfoResponse(
        id: id,
        name: name,
        imageUrl: imageUrl,
        types: types,
        height: height,
        weight: weight);
  }
}

class PokemonSpeciesInfoResponse {
  final String description;
  PokemonSpeciesInfoResponse({required this.description});

  factory PokemonSpeciesInfoResponse.fromJson(Map<String, dynamic> json) {
    final String description = json['flavor_text_entries'][0]['flavor_text'];
    return PokemonSpeciesInfoResponse(description: description);
  }
}
