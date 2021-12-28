abstract class PokemonEvent {}

class RequestPokemonPage extends PokemonEvent {
  final int page;

  RequestPokemonPage({required this.page});
}
