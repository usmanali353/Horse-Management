class Paddocks {

  int _id;
  String _name;
  String _main_use;
  int _location;
  String _area;
  int _has_shade;
  int _has_water;
  String _grass;
  String _other_animals;
  String _date;
  String _comments;


  Paddocks(this._name, this._main_use, this._location, this._area, this._has_shade, this._has_water,
      this._grass, this._other_animals, this._date, [this._comments]);

  Paddocks.withId(this._id, this._name, this._main_use, this._location, this._area, this._has_shade, this._has_water, this._grass, this._date, this._other_animals, [this._comments]);

  int get id => _id;
  String get name => _name;
  String get main_use => _main_use;
  int get location => _location;
  String get area => _area;
  int get has_shade => _has_shade;
  int get has_water => _has_water;
  String get grass => _grass;
  String get other_animals => _other_animals;
  String get comments => _comments;
  String get date => _date;

  set name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }
  }
  set main_use(String newMainUse) {
    if (newMainUse.length <= 255) {
      this._main_use = newMainUse;
    }
  }

  set location(int newLocation) {
      this._location = newLocation;
  }

  set area(String newArea) {
    if (newArea.length <= 255) {
      this._area = newArea;
    }
  }
  set has_shade(int newHasShade) {
    if (newHasShade >= 1 && newHasShade <= 2) {
      this._has_shade = newHasShade;
    }
  }
  set has_water(int newHasWater) {
    if (newHasWater >= 1 && newHasWater <= 2) {
      this._has_shade = newHasWater;
    }
  }

  set grass(String newGrass) {
    if (newGrass.length <= 255) {
      this._grass = newGrass;
    }
  }

  set other_animals(String newOtherAnimals) {
    if (newOtherAnimals.length <= 255) {
      this._other_animals = newOtherAnimals;
    }
  }

  set comments(String newComments) {
    if (newComments.length <= 255) {
      this._comments = newComments;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['main_use'] = _main_use;
    map['location'] = _location;
    map['area'] = _area;
    map['has_shade'] = _has_shade;
    map['has_water'] = _has_water;
    map['grass'] = _grass;
    map['other_animals'] = _other_animals;
    map['comments'] = _comments;
    map['date'] = _date;

    return map;
  }

  // Extract a Horse object from a Map object
  Paddocks.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._main_use = map['main_use'];
    this._location = map['location'];
    this._area = map['area'];
    this._has_shade = map['has_shade'];
    this._has_water = map['has_water'];
    this._grass = map['grass'];
    this._other_animals = map['other_animals'];
    this._comments = map['comments'];
    this._date = map['date'];

  }
}