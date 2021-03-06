import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pokedex_app/data/pokemon_model.dart';
import 'package:pokedex_app/data/pokemon_repository.dart';

import 'pokemon_event.dart';
import 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _pokemonRepository = PokemonRepository();

  PokemonBloc() : super(PokemonInitialState());

  @override
  Stream<PokemonState> mapEventToState(PokemonEvent event) async* {
    if (event is RequestPokemonPage) {
      yield PokemonLoadingState();
      try {
        final PokemonPageResponse pokemonPage =
            await _pokemonRepository.getPokemonPage(event.page);
        yield PokemonLoadSuccessState(
          pokemonList: pokemonPage.pokemonList,
          canLoadNext: pokemonPage.canLoadNext,
          canLoadPrev: pokemonPage.canLoadPrev,
        );
      } catch (e) {
        yield PokemonLoadFailedState(error: e);
      }
    }
    return;
  }
}
