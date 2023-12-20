class Club {
  int? id;
  String? name;
  User? user;
  String? address;
  List<Followers>? followers;
  List<Stadiums>? stadiums;

  Club(
      {this.id,
      this.name,
      this.user,
      this.address,
      this.followers,
      this.stadiums});

  Club.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    address = json['address'];
   if (json['followers'] != null) {
      followers = <Followers>[];
      json['followers'].forEach((v) {
        followers!.add(new Followers.fromJson(v));
      });
    }
    if (json['stadiums'] != null) {
      stadiums = <Stadiums>[];
      json['stadiums'].forEach((v) {
        stadiums!.add(new Stadiums.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['address'] = this.address;
     if (this.followers != null) {
      data['followers'] = this.followers!.map((v) => v.toJson()).toList();
    }
    if (this.stadiums != null) {
      data['stadiums'] = this.stadiums!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? role;
  List<Null>? followedClubs;
  bool? accountNonExpired;
  bool? credentialsNonExpired;
  bool? accountNonLocked;
  List<Authorities>? authorities;
  String? username;
  bool? enabled;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.role,
      this.followedClubs,
      this.accountNonExpired,
      this.credentialsNonExpired,
      this.accountNonLocked,
      this.authorities,
      this.username,
      this.enabled});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    role = json['role'];
    if (json['followedClubs'] != null) {
      followedClubs = <Null>[];
      json['followedClubs'].forEach((v) {
        // followedClubs!.add(new Null.fromJson(v));
      });
    }
    accountNonExpired = json['accountNonExpired'];
    credentialsNonExpired = json['credentialsNonExpired'];
    accountNonLocked = json['accountNonLocked'];
    if (json['authorities'] != null) {
      authorities = <Authorities>[];
      json['authorities'].forEach((v) {
        authorities!.add(new Authorities.fromJson(v));
      });
    }
    username = json['username'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['role'] = this.role;
    if (this.followedClubs != null) {
      // data['followedClubs'] =
          // this.followedClubs!.map((v) => v.toJson()).toList();
    }
    data['accountNonExpired'] = this.accountNonExpired;
    data['credentialsNonExpired'] = this.credentialsNonExpired;
    data['accountNonLocked'] = this.accountNonLocked;
    if (this.authorities != null) {
      data['authorities'] = this.authorities!.map((v) => v.toJson()).toList();
    }
    data['username'] = this.username;
    data['enabled'] = this.enabled;
    return data;
  }
}

class Authorities {
  String? authority;

  Authorities({this.authority});

  Authorities.fromJson(Map<String, dynamic> json) {
    authority = json['authority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authority'] = this.authority;
    return data;
  }
}

class Stadiums {
  int? id;
  String? name;
  String? size;
  String? features;
  String? cost;
  String? description;
  List<String>? images;
  List<Reservations>? reservations;

  Stadiums(
      {this.id,
      this.name,
      this.size,
      this.features,
      this.cost,
      this.description,
      this.images,
      this.reservations});

  Stadiums.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    size = json['size'];
    features = json['features'];
    cost = json['cost'];
    description = json['description'];
    images = json['images'].cast<String>();
    if (json['reservations'] != null) {
      reservations = <Reservations>[];
      json['reservations'].forEach((v) {
        reservations!.add(new Reservations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
    data['features'] = this.features;
    data['cost'] = this.cost;
    data['description'] = this.description;
    data['images'] = this.images;
    if (this.reservations != null) {
      data['reservations'] = this.reservations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reservations {
  int? id;
  User? user;
  String? playerName;
  String? reservationTime;
  String? status;

  Reservations(
      {this.id, this.user, this.playerName, this.reservationTime, this.status});

  Reservations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    playerName = json['playerName'];
    reservationTime = json['reservationTime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['playerName'] = this.playerName;
    data['reservationTime'] = this.reservationTime;
    data['status'] = this.status;
    return data;
  }
}
class Followers {
  int? id;
  Club? club;
  User? user;

  Followers({this.id, this.club, this.user});

  Followers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    club = json['club'] != null ? new Club.fromJson(json['club']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.club != null) {
      data['club'] = this.club!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}