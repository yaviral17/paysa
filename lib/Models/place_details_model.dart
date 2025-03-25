class PlaceDetailsModel {
  String? name;
  String? address;
  String? placeId;
  double? lat;
  double? lng;

  PlaceDetailsModel(
      {this.name, this.address, this.placeId, this.lat, this.lng});

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsModel(
        name: json['name'],
        address: json['address'],
        placeId: json['placeId'],
        lat: json['lat'],
        lng: json['lng']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'placeId': placeId,
      'lat': lat,
      'lng': lng
    };
  }
}
