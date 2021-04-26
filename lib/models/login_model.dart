class LoginModel {
  String? host;
  String? consumerKey;
  String? consumerSecret;

  LoginModel({this.host, this.consumerKey, this.consumerSecret});

  LoginModel.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    consumerKey = json['consumer_key'];
    consumerSecret = json['consumer_secret'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['host'] = this.host;
    data['consumer_key'] = this.consumerKey;
    data['consumer_secret'] = this.consumerSecret;
    return data;
  }
}
