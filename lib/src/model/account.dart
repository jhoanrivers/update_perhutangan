
class Account{
  int id;
  String username;
  String password;
  String fcmtoken;
  String name;
  String gopay;
  String ovo;
  bool isSelected = false;


  Account({
    this.id,
    this.username,
    this.password,
    this.fcmtoken,
    this.name,
    this.gopay,
    this.ovo,
    this.isSelected
  });


   Account.fromJson(Map<String, dynamic> json) {
     this.id = json['id'];
     this.username =json['username'];
     this.name = json['name'];
     this.password = json['password'];
     this.fcmtoken = json['fcmtoken'];
     this.gopay = json['gopay'];
     this.ovo = json['ovo'];
  }


  Map<String, dynamic> toJson() => {
     'id' : this.id,
    'username' : this.username,
    'password' : this.password,
    'name' : this.name,
    'fcmtoken' : this.fcmtoken,
    'gopay' : this.gopay,
    'ovo' : this.ovo
  };


}