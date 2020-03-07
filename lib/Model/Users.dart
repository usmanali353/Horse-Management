class Users {
  String firstname;
  String email;
  String password;
  String confirmPassword;
  Users({this.firstname, this.email, this.password, this.confirmPassword});

  Users.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    email = json['email'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['confirmPassword'] = this.confirmPassword;
    return data;
  }

  Users.secondary(this.email, this.password);


}