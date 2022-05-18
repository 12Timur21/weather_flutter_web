import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_application_1/models/place_card_model.dart';
import 'package:flutter_application_1/services/google_place_api.dart';

class PlaceCard extends StatefulWidget {
  const PlaceCard({
    required this.placeCardModel,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final PlaceCardModel placeCardModel;
  final Function(PlaceCardModel) onTap;

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  late PlaceCardModel _placeCardModel;
  late Color cardColor;
  Uint8List? photoBytes;

  @override
  void initState() {
    _placeCardModel = widget.placeCardModel;

    cardColor = Color(
      (math.Random().nextDouble() * 0xFFFFFF).toInt(),
    ).withOpacity(
      1.0,
    );

    _loadImage();

    super.initState();
  }

  Future<void> _loadImage() async {
    try {
      photoBytes = await GooglePlaceAPI.instance.getPhoto(
        photoReference: _placeCardModel.photoReference!,
      );
      setState(() {});
    } catch (e) {
      log('No photo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => widget.onTap(_placeCardModel),
        child: Column(
          children: [
            ClipPath.shape(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(
                  color: Colors.red,
                ),
              ),
              child: Container(
                width: 200,
                height: 250,
                color: cardColor,
                child: photoBytes != null
                    ? Image.memory(
                        photoBytes!,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox(),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  widget.placeCardModel.placeName ?? 'No name',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
