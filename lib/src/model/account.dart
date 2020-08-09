class Account {
  int id;
  String username;
  String password;
  String fcmtoken;
  String name;
  String gopay;
  String gopayName;
  String ovo;
  String ovoName;
  bool isSelected = false;

  Account(
      {this.id,
      this.username,
      this.password,
      this.fcmtoken,
      this.name,
      this.gopay,
      this.gopayName,
      this.ovo,
      this.ovoName,
      this.isSelected});

  Account.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.username = json['username'];
    this.name = json['name'];
    this.password = json['password'];
    this.fcmtoken = json['fcm_token'];
    this.gopay = json['gopay'];
    this.gopayName = json['gopay_name'];
    this.ovo = json['ovo'];
    this.ovoName = json['ovo_name'];
  }

  Map<String, dynamic> toMap() => {
        'id_user': this.id,
        'username': this.username,
        'name': this.name,
        'fcm_token': this.fcmtoken,
        'gopay': this.gopay,
        'gopay_name': this.gopayName,
        'ovo': this.ovo,
        'ovo_name': this.ovoName,
      };
}
