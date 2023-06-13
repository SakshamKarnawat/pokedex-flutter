import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/data/pokemon_repository.dart';

import '../data/pokemon_model.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  PokemonBloc() : super(PokemonInitialState()) {
    on<PokemonEvent>(
      mapEventToState,
      transformer: sequential(),
    );
  }

  final PokemonRepository _pokemonRepository = PokemonRepository();

  Future<void> mapEventToState(
    PokemonEvent event,
    Emitter<PokemonState> emit,
  ) async {
    if (event is RequestPokemonPage) {
      emit(PokemonLoadingState());
      try {
        final PokemonPageResponse pokemonPage =
            await _pokemonRepository.getPokemonPage(event.page);
        emit(PokemonLoadSuccessState(
          pokemonList: pokemonPage.pokemonList,
          canLoadNext: pokemonPage.canLoadNext,
          canLoadPrev: pokemonPage.canLoadPrev,
        ));
      } catch (e) {
        emit(PokemonLoadFailedState(error: e));
      }
    }
    return;
  }
}
