import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app_navigator.dart';
import 'package:pokedex/bloc/nav_cubit.dart';
import 'package:pokedex/bloc/pokemon_bloc.dart';

import 'bloc/pokemon_details_cubit.dart';
import 'bloc/pokemon_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PokemonDetailsCubit pokemonDetailsCubit = PokemonDetailsCubit();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Theme.of(context).copyWith(
        // primaryColor: Colors.red,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(primary: Colors.red, secondary: Colors.redAccent),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                PokemonBloc()..add(RequestPokemonPage(page: 0)),
          ),
          BlocProvider(
              create: (context) =>
                  NavCubit(pokemonDetailsCubit: pokemonDetailsCubit)),
          BlocProvider(create: (context) => pokemonDetailsCubit),
        ],
        child: const AppNavigator(),
      ),
    );
  }
}
