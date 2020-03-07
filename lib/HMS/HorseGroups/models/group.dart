class Groups {

  int _id;
  String _name;
  String _comments;
  int _dynamics;
  String _date;

  Groups(this._name, this._dynamics, this._date, [this._comments]);

  Groups.withId(this._id, this._name, this._dynamics,this._date, [this._comments]);

  int get id => _id;

  String get name => _name;

  String get comments => _comments;

  int get dynamics => _dynamics;

  String get date => _date;

  set name(String newName) {
    if (newName.length <= 255) {
      this._name = newName;
    }
  }

  set comments(String newComments) {
    if (newComments.length <= 255) {
      this._comments = newComments;
    }
  }

  set dynamics(int newDynamics) {
    if (newDynamics >= 1 && newDynamics <= 2) {
      this._dynamics = newDynamics;
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
    map['comments'] = _comments;
    map['dynamics'] = _dynamics;
    map['date'] = _date;


    return map;
  }

  // Extract a Horse object from a Map object
  Groups.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._comments = map['comments'];
    this._dynamics = map['dynamics'];
    this._date = map['date'];

  }
}