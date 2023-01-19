import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/data/pokemon_model.dart';

class PokemonRepository {
  final String baseUrl = 'pokeapi.co';
  final http.Client client = http.Client();

  Future<PokemonPageResponse> getPokemonPage(int pageIndex) async {
    final Map<String, dynamic> queryParams = {
      'limit': '50',
      'offset': '$pageIndex',
      // 'offset': (pageIndex * 200).toString(),
    };
    final Uri uri = Uri.https(baseUrl, '/api/v2/pokemon', queryParams);
    final http.Response response = await client.get(uri);
    final json = jsonDecode(response.body);
    return PokemonPageResponse.fromJson(json);
  }

  Future<PokemonInfoResponse?> getPokemonInfo(int pokemonId) async {
    final Uri uri = Uri.https(baseUrl, '/api/v2/pokemon/$pokemonId');

    try {
      final http.Response response = await client.get(uri);
      final json = jsonDecode(response.body);
      return PokemonInfoResponse.fromJson(json);
    } catch (e) {
      // print(e.toString());
    }
  }

  Future<PokemonSpeciesInfoResponse?> getPokemonSpeciesInfo(
      int pokemonId) async {
    final Uri uri = Uri.https(baseUrl, '/api/v2/pokemon-species/$pokemonId');

    try {
      final http.Response response = await client.get(uri);
      final json = jsonDecode(response.body);
      return PokemonSpeciesInfoResponse.fromJson(json);
    } catch (e) {
      // print(e.toString());
    }
  }
}
