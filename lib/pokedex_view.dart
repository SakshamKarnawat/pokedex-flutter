import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/nav_cubit.dart';
import 'bloc/pokemon_bloc.dart';
import 'bloc/pokemon_event.dart';
import 'bloc/pokemon_state.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({Key? key}) : super(key: key);

  @override
  _PokedexViewState createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        centerTitle: true,
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(builder: (context, state) {
        if (state is PokemonLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PokemonLoadSuccessState) {
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemCount: state.pokemonList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => BlocProvider.of<NavCubit>(context)
                            .showPokemonDetails(state.pokemonList[index].id),
                        child: Card(
                          elevation: 4,
                          child: GridTile(
                            child: Column(
                              children: [
                                Image.network(
                                    state.pokemonList[index].imageUrl),
                                Text(
                                    "${state.pokemonList[index].name[0].toUpperCase()}${state.pokemonList[index].name.substring(1)}"),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: state.canLoadPrev
                            ? () {
                                BlocProvider.of<PokemonBloc>(context).add(
                                    RequestPokemonPage(
                                        page: state.pokemonList.first.id - 51));
                              }
                            : null,
                        child: const Text('Previous'),
                      ),
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child: TextButton(
                          onPressed: state.canLoadNext
                              ? () {
                                  BlocProvider.of<PokemonBloc>(context).add(
                                      RequestPokemonPage(
                                          page: state.pokemonList.last.id));
                                }
                              : null,
                          child: const Text('Next')),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (state is PokemonLoadFailedState) {
          // print(state.error.toString());
          return const Center(
            child:
                Text("Error while loading! Please try opening the app later."),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
