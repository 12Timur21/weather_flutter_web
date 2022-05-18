import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/models/place_card_model.dart';
import 'package:meta/meta.dart';

part 'place_cards_event.dart';
part 'place_cards_state.dart';

class PlaceCardsBloc extends Bloc<PlaceCardsEvent, PlaceCardsState> {
  PlaceCardsBloc() : super(const PlaceCardsState()) {
    on<AddPlaceCard>((event, emit) {
      List<PlaceCardModel> allPlaceCardModels = [...state.placeCardModel];
      allPlaceCardModels.add(event.placeCardModel);

      emit(
        state.copyWith(
          placeCardModel: allPlaceCardModels,
        ),
      );
    });

    on<RemovePlaceCard>((event, emit) {
      List<PlaceCardModel> allPlaceCardModels = [...state.placeCardModel];
      allPlaceCardModels.remove(event.placeCardModel);

      emit(
        state.copyWith(
          placeCardModel: allPlaceCardModels,
        ),
      );
    });
  }
}
