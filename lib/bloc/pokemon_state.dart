import '../data/pokemon_model.dart';

abstract class PokemonState {}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadSuccessState extends PokemonState {
  final List<Pokemon> pokemonList;
  final bool canLoadNext;
  final bool canLoadPrev;

  PokemonLoadSuccessState(
      {required this.pokemonList,
      required this.canLoadNext,
      required this.canLoadPrev});
}

class PokemonLoadFailedState extends PokemonState {
  final error;
  PokemonLoadFailedState({required this.error});
}
