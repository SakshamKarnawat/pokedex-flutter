import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/pokemon_model.dart';
import 'package:pokedex/data/pokemon_repository.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetails?> {
  final PokemonRepository _pokemonRepository = PokemonRepository();
  PokemonDetailsCubit() : super(null);

  void getPokemonDetails(int id) async {
    final responses = await Future.wait([
      _pokemonRepository.getPokemonInfo(id),
      _pokemonRepository.getPokemonSpeciesInfo(id),
    ]);
    final PokemonInfoResponse pokemonInfo = responses[0] as PokemonInfoResponse;
    final PokemonSpeciesInfoResponse speciesInfo =
        responses[1] as PokemonSpeciesInfoResponse;

    emit(PokemonDetails(
        id: pokemonInfo.id,
        name: pokemonInfo.name,
        imageUrl: pokemonInfo.imageUrl,
        types: pokemonInfo.types,
        height: pokemonInfo.height,
        weight: pokemonInfo.weight,
        description: speciesInfo.description));
  }

  void clearPokemonDetails() => emit(null);
}
