class Club {
  String? _name;
  List<Stadiums>? _stadiums;
  String? _address;
  Location? _location;
  String? _description;

  Club(
      {String? name,
      List<Stadiums>? stadiums,
      String? address,
      Location? location,
      String? description}) {
    if (name != null) {
      _name = name;
    }
    if (stadiums != null) {
      _stadiums = stadiums;
    }
    if (address != null) {
      _address = address;
    }
    if (location != null) {
      _location = location;
    }
    if (description != null) {
      _description = description;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  List<Stadiums>? get stadiums => _stadiums;
  set stadiums(List<Stadiums>? stadiums) => _stadiums = stadiums;
  String? get address => _address;
  set address(String? address) => _address = address;
  Location? get location => _location;
  set location(Location? location) => _location = location;
  String? get description => _description;
  set description(String? description) => _description = description;

  Club.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    if (json['stadiums'] != null) {
      _stadiums = <Stadiums>[];
      json['stadiums'].forEach((v) {
        _stadiums!.add(Stadiums.fromJson(v));
      });
    }
    _address = json['address'];
    _location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    _description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['name'] = _name;
    if (_stadiums != null) {
      data['stadiums'] = _stadiums!.map((v) => v.toJson()).toList();
    }
    data['address'] = _address;
    if (_location != null) {
      data['location'] = _location!.toJson();
    }
    data['description'] = _description;
    return data;
  }
}

class Stadiums {
  String? _name;
  List<String>? _photos;
  int? _size;

  Stadiums({String? name, List<String>? photos, int? size}) {
    if (name != null) {
      _name = name;
    }
    if (photos != null) {
      _photos = photos;
    }
    if (size != null) {
      _size = size;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  List<String>? get photos => _photos;
  set photos(List<String>? photos) => _photos = photos;
  int? get size => _size;
  set size(int? size) => _size = size;

  Stadiums.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _photos = json['photos'].cast<String>();
    _size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = _name;
    data['photos'] = _photos;
    data['size'] = _size;
    return data;
  }
}

class Location {
  double? _latitude;
  double? _longitude;

  Location({double? latitude, double? longitude}) {
    if (latitude != null) {
      _latitude = latitude;
    }
    if (longitude != null) {
      _longitude = longitude;
    }
  }

  double? get latitude => _latitude;
  set latitude(double? latitude) => _latitude = latitude;
  double? get longitude => _longitude;
  set longitude(double? longitude) => _longitude = longitude;

  Location.fromJson(Map<String, dynamic> json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['latitude'] = _latitude;
    data['longitude'] = _longitude;
    return data;
  }
}