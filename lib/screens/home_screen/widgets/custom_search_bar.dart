import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/place_card_model.dart';
import 'package:flutter_application_1/services/google_place_api.dart';
import 'package:flutter_application_1/utils/toast_box.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_place/google_place.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final Function(PlaceCardModel) onSubmit;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  Future<List<PlaceCardModel>> _suggestionsCallback(String value) async {
    List<PlaceCardModel> placeCardModelsList = [];

    try {
      List<AutocompletePrediction> autocompletePrediction =
          await GooglePlaceAPI.instance.getAutocomplete(
        placeName: value,
      );

      for (AutocompletePrediction element in autocompletePrediction) {
        placeCardModelsList.add(
          PlaceCardModel(
            placeName: element.description,
            placeID: element.reference,
          ),
        );
      }
    } catch (e) {
      FocusScope.of(context).unfocus();
      ToastBox.instance.showErrorToast(
        context: context,
        text: 'Не удалось получить ответ от сервера',
      );
      log(e.toString());
    }

    return placeCardModelsList;
  }

  void _onSuggestionSelected(PlaceCardModel placeCardModel) async {
    try {
      DetailsResult placeDetails = await GooglePlaceAPI.instance.getDetails(
        placeId: placeCardModel.placeID!,
      );
      Location location = placeDetails.geometry!.location!;

      widget.onSubmit(
        placeCardModel.copyWith(
          photoReference: placeDetails.photos![0].photoReference!,
          location: PlaceLocation(
            lat: location.lat!,
            lng: location.lng!,
          ),
        ),
      );
    } catch (e) {
      ToastBox.instance.showErrorToast(
        context: context,
        text: 'Не удалось получить данные о этом регионе',
      );
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<PlaceCardModel>(
      suggestionsBoxDecoration: const SuggestionsBoxDecoration(
        color: Colors.white,
      ),
      textFieldConfiguration: TextFieldConfiguration(
        autofocus: true,
        style: DefaultTextStyle.of(context).style.copyWith(
              fontSize: 20,
              color: Colors.black,
            ),
        decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.search,
              size: 30,
              color: Color(0xFF888791),
            ),
          ),
          hintText: 'Search...',
          hintStyle: const TextStyle(
            color: Color(0xFFCECDD5),
            fontSize: 20,
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
      suggestionsCallback: _suggestionsCallback,
      itemBuilder: (context, suggestion) {
        return ListTile(
          mouseCursor: MouseCursor.defer,
          contentPadding: const EdgeInsets.only(left: 30),
          title: Text(
            suggestion.placeName ?? '',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        );
      },
      onSuggestionSelected: _onSuggestionSelected,
    );
  }
}
