class OwnedClubs {
  Location? location;
  String? sId;
  String? name;
  List<Stadiums>? stadiums;
  List<Null>? followers;
  String? address;
  String? cost;
  List<String>? photos;
  int? iV;

  OwnedClubs(
      {this.location,
      this.sId,
      this.name,
      this.stadiums,
      this.followers,
      this.address,
      this.cost,
      this.photos,
      this.iV});

  OwnedClubs.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    name = json['name'];
    if (json['stadiums'] != null) {
      stadiums = <Stadiums>[];
      json['stadiums'].forEach((v) {
        stadiums!.add(new Stadiums.fromJson(v));
      });
    }
    if (json['followers'] != null) {
      followers = <Null>[];
      json['followers'].forEach((v) {
        // followers!.add(new Null.fromJson(v));
      });
    }
    address = json['address'];
    cost = json['cost'];
    photos = json['photos'].cast<String>();
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.stadiums != null) {
      data['stadiums'] = this.stadiums!.map((v) => v.toJson()).toList();
    }
    if (this.followers != null) {
      // data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    data['address'] = this.address;
    data['cost'] = this.cost;
    data['photos'] = this.photos;
    data['__v'] = this.iV;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class Stadiums {
  String? sId;
  String? name;
  List<String>? photos;
  int? size;
  List<Availability>? availability;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Stadiums(
      {this.sId,
      this.name,
      this.photos,
      this.size,
      this.availability,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Stadiums.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    photos = json['photos'].cast<String>();
    size = json['size'];
    if (json['availability'] != null) {
      availability = <Availability>[];
      json['availability'].forEach((v) {
        availability!.add(new Availability.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['photos'] = this.photos;
    data['size'] = this.size;
    if (this.availability != null) {
      data['availability'] = this.availability!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Availability {
  String? date;
  List<Slots>? slots;
  String? sId;

  Availability({this.date, this.slots, this.sId});

  Availability.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['slots'] != null) {
      slots = <Slots>[];
      json['slots'].forEach((v) {
        slots!.add(new Slots.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.slots != null) {
      data['slots'] = this.slots!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class Slots {
  int? hour;
  String? status;
  String? sId;

  Slots({this.hour, this.status, this.sId});

  Slots.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    status = json['status'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['status'] = this.status;
    data['_id'] = this.sId;
    return data;
  }
}