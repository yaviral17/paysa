import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:paysa/Models/place_details_model.dart';
import 'package:paysa/firebase_options.dart';
import 'package:permission_handler/permission_handler.dart';

class ApiFunctions extends GetxController {
  String googleCloudKey = DefaultFirebaseOptions.apiKey;
  String googleMapUrl = 'maps.googleapis.com';
  LatLng? currentLocation;

  Future<Map<String, dynamic>?> getPlaceDetails(String placeId) async {
    try {
      Map<String, String> query = {
        "place_id": placeId,
        "key": googleCloudKey,
      };
      Uri url = Uri.https(googleMapUrl, "/maps/api/place/details/json", query);
      final http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse['status'] == 'OK') {
          return jsonResponse['result'];
        }
      } else {
        log("Failed to fetch places. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log("Exception occurred: $e");
      throw e;
    }
    return null;
  }

  Future<PlaceDetailsModel?> getAddressFromLatLng(
      double lat, double lng) async {
    try {
      Map<String, String> query = {
        "latlng": "$lat,$lng",
        "key": googleCloudKey,
      };
      Uri url = Uri.https(googleMapUrl, "/maps/api/geocode/json", query);
      final http.Response response = await http.post(url);
      // log("Current Location: ${apiFunctions.currentLocation}");
      log("API URL: ${url.toString()}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'OK' &&
            jsonResponse['results'].isNotEmpty) {
          log("Response Body: ${jsonResponse['results'][0]['formatted_address']}");
          PlaceDetailsModel placeDetailsModel = PlaceDetailsModel.fromJson({
            "address": jsonResponse['results']?[0]['formatted_address'],
            "name": jsonResponse['results']?[0]['address_components'][0]
                ['long_name'],
            "placeId": jsonResponse['results']?[0]['place_id'],
            "lat": lat,
            "lng": lng,
          });
          return placeDetailsModel;
        }
      } else {
        log("Failed to fetch address. Status code:  ${response.statusCode}");
      }
    } catch (e) {
      log("Exception occurred: $e");
    }
    return null;
  }

  Future<void> checkPermissionsAndGetLocation() async {
    // var status = await Permission.location.request();
    // if (status.isGranted) {
    //   _getCurrentLocation();
    // } else if (status.isDenied) {
    //   Permission.location.request();

    // }
    // }

    Geolocator.requestPermission().then((value) {
      if (value == LocationPermission.always ||
          value == LocationPermission.whileInUse) {
        _getCurrentLocation();
      } else {
        log("Location permission denied");
      }
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      currentLocation = LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("Error: ${e.toString()}");
    }
  }
}
