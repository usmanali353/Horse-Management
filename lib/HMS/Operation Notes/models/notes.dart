class Notes {

  int _id;
  String _comments;
  int _general_category;
  String _date;

  Notes(this._general_category, this._date, [this._comments]);

  Notes.withId(this._id, this._general_category,this._date, [this._comments]);

  int get id => _id;

  String get date => _date;

  int get general_category => _general_category;

  String get comments => _comments;

  set date(String newDate) {
    this._date = newDate;
  }


  set general_category(int newGeneral_Category) {
    if (newGeneral_Category >= 1 && newGeneral_Category <= 200) {
      this._general_category = general_category;
    }
  }

  set comments(String newComments) {
    if (newComments.length <= 255) {
      this._comments = newComments;
    }
  }


  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['date'] = _date;
    map['general_category'] = _general_category;
    map['comments'] = _comments;




    return map;
  }

  // Extract a Horse object from a Map object
  Notes.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._date = map['date'];
    this._general_category = map['dynamics'];
    this._comments = map['comments'];

  }
}