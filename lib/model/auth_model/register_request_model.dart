class RegisterRequest {
  String? id;
  String? fname;
  String? password;
  String? email;

  RegisterRequest({
    this.id,
    this.fname,
    this.password,
    this.email,
  });

  toMap() {
    return {
      'id': this.id,
      'fname': this.fname,
      'email': this.email,
    };
  }
}
