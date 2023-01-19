import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:pokedex/bloc/pokemon_details_cubit.dart';

import 'data/pokemon_model.dart';

class PokemonDetailsView extends StatelessWidget {
  final FlutterTts tts = FlutterTts();
  PokemonDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Details'),
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: BlocBuilder<PokemonDetailsCubit, PokemonDetails?>(
        builder: (context, details) {
          if (details != null) {
            tts.speak(
              details.description
                  .replaceAll('\n', ' ')
                  .replaceAll('\u000c', ' '),
            );
            return Center(
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.network(details.imageUrl),
                          Text(
                            "${details.name[0].toUpperCase()}${details.name.substring(1)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: details.types
                                .map((type) => _pokemonTypeView(type))
                                .toList(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('ID: ${details.id}'),
                              Text('Weight: ${details.weight}'),
                              Text('Height: ${details.height}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              const Text(
                                'Description',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                details.description
                                    .replaceAll('\n', ' ')
                                    .replaceAll('\u000c', ' '),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          tts.stop();
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _pokemonTypeView(String type) {
    Color color;

    switch (type) {
      case 'normal':
        color = const Color(0xFFbdbeb0);
        break;
      case 'poison':
        color = const Color(0xFF995E98);
        break;
      case 'psychic':
        color = const Color(0xFFE96EB0);
        break;
      case 'grass':
        color = const Color(0xFF9CD363);
        break;
      case 'ground':
        color = const Color(0xFFE3C969);
        break;
      case 'ice':
        color = const Color(0xFFAFF4FD);
        break;
      case 'fire':
        color = const Color(0xFFE7614D);
        break;
      case 'rock':
        color = const Color(0xFFCBBD7C);
        break;
      case 'dragon':
        color = const Color(0xFF8475F7);
        break;
      case 'water':
        color = const Color(0xFF6DACF8);
        break;
      case 'bug':
        color = const Color(0xFFC5D24A);
        break;
      case 'dark':
        color = const Color(0xFF886958);
        break;
      case 'fighting':
        color = const Color(0xFF9E5A4A);
        break;
      case 'ghost':
        color = const Color(0xFF7774CF);
        break;
      case 'steel':
        color = const Color(0xFFC3C3D9);
        break;
      case 'flying':
        color = const Color(0xFF81A2F8);
        break;
      /* case 'normal':
        color = Color(0xFFF9E65E);
        break; */
      case 'fairy':
        color = const Color(0xFFEEB0FA);
        break;
      default:
        color = Colors.black;
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Text(
          type.toUpperCase(),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
