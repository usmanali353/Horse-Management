class BreedingControl {

  int _id;
  String _horse_name;
  String _date;
  int _hours;
  int _check_method;
  int _vet;
  int _related_services;
  int _empty;
  int _pregnancy;
  int _abortion;
  int _reabsorption;
  int _follicle;
  int _ovule;
  int _twins;
  int _volvoplasty;



 // BreedingControl(this._name, this._dynamics, this._date, [this._comments]);

  BreedingControl.withId(this._id, this._horse_name, this._date, this._hours,this._check_method,this._vet,this._related_services,this._empty,this._pregnancy,this._abortion,this._reabsorption,this._follicle,this._ovule,this._twins,this._volvoplasty);

  int get id => _id;

  String get horse_name => _horse_name;

  String get date => _date;
  int get hours => _hours;
  int get check_method => _check_method;
  int get vet => _vet;
  int get related_services => _related_services;
  int get empty => _empty;
  int get pregnancy => _pregnancy;
  int get abortion => _abortion;
  int get reabsorption => _reabsorption;
  int get follicle => _follicle;
  int get ovule => _ovule;
  int get twins => _twins;
  int get volvoplasty => _volvoplasty;




  set horse_name(String newName) {
      this._horse_name = newName;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set hours(int newHours) {
    this._date = newHours as String;
  }
  set check_method(int newCheckMethod) {
    this._check_method = newCheckMethod;
  }
  set vet(int newVet) {
    this._vet = newVet;
  }
  set related_services(int newRelatedServices) {
    this._related_services = newRelatedServices;
  }

  set empty(int newEmpty) {
    if (newEmpty >= 1 && newEmpty <= 2) {
      this._empty = newEmpty;
    }
  }
  set pregnancy(int newPregnancy) {
    if (newPregnancy >= 1 && newPregnancy <= 2) {
      this._pregnancy = newPregnancy;
    }
  }
  set abortion(int newAbortion) {
    if (newAbortion >= 1 && newAbortion <= 2) {
      this._abortion = newAbortion;
    }
  }

  set reabsorption(int newReabsorption) {
    if (newReabsorption >= 1 && newReabsorption <= 2) {
      this._reabsorption = newReabsorption;
    }
  }
  set follicle(int newFollicle) {
    if (newFollicle >= 1 && newFollicle <= 2) {
      this._follicle = newFollicle;
    }
  }
  set ovule(int newOvule) {
    if (newOvule >= 1 && newOvule <= 2) {
      this._reabsorption = newOvule;
    }
  }
  set twins(int newTwins) {
    if (newTwins >= 1 && newTwins <= 2) {
      this._twins = newTwins;
    }
  }
  set volvoplasty(int newVolvoplasty) {
    if (newVolvoplasty >= 1 && newVolvoplasty <= 2) {
      this._volvoplasty = newVolvoplasty;
    }
  }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['horse_name'] = _horse_name;
    map['date'] = _date;
    map['hours'] = _hours;
    map['check_method'] = _check_method;
    map['vet'] = _vet;
    map['related_services'] = _related_services;
    map['empty'] = _empty;
    map['pregnancy'] = _pregnancy;
    map['abortion'] = _abortion;
    map['reabsorption'] = _reabsorption;
    map['follicle'] = _follicle;
    map['ovule'] = _ovule;
    map['twins'] = _twins;
    map['volvoplasty'] = _volvoplasty;

    return map;
  }

  // Extract a Horse object from a Map object
  BreedingControl.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._horse_name = map['horse_name'];
    this._date = map['date'];
    this._hours = map['hours'];
    this._check_method = map['check_method'];
    this._vet = map['vet'];
    this._related_services = map['related_services'];
    this._empty = map['empty'];
    this._pregnancy = map['pregnancy'];
    this._abortion = map['abortion'];
    this._reabsorption = map['reabsorption'];
    this._follicle = map['follicle'];
    this._ovule = map['ovule'];
    this._twins = map['twins'];
    this._volvoplasty = map['volvopasty'];

  }
}