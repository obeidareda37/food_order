class UserModel {
  String? id;
  String? email;
  String? fname;

  UserModel({
    this.id,
    this.email,
    this.fname,
  });

  UserModel.fromMap(Map map) {
    this.id = map['id'];
    this.email = map['email'];
    this.fname = map['fname'];
  }

  toMap() {
    return {
      'fname': this.fname,
      'email': this.email,
    };
  }
}
