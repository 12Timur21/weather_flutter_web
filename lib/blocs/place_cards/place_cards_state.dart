part of 'place_cards_bloc.dart';

@immutable
class PlaceCardsState extends Equatable {
  final List<PlaceCardModel> placeCardModel;

  const PlaceCardsState({
    this.placeCardModel = const [],
  });

  PlaceCardsState copyWith({
    List<PlaceCardModel>? placeCardModel,
  }) {
    return PlaceCardsState(
      placeCardModel: placeCardModel ?? this.placeCardModel,
    );
  }

  @override
  List<Object> get props => [placeCardModel];
}
