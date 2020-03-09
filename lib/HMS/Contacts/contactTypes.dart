class contactTypes{
  int contactTypeId;
  contactTypes(this.contactTypeId);
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["contactTypeId"] = contactTypeId;
    return map;
  }
}