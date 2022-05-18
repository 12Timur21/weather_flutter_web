part of 'place_cards_bloc.dart';

@immutable
abstract class PlaceCardsEvent {}

class AddPlaceCard extends PlaceCardsEvent {
  final PlaceCardModel placeCardModel;

  AddPlaceCard(this.placeCardModel);
}

class RemovePlaceCard extends PlaceCardsEvent {
  final PlaceCardModel placeCardModel;

  RemovePlaceCard(this.placeCardModel);
}
