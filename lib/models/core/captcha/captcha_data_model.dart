class CaptchaDataModel {
  bool? status;
  String? sessionId;
  String? data;

  CaptchaDataModel({this.status, this.sessionId, this.data});

  CaptchaDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sessionId = json['sessionId'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['sessionId'] = this.sessionId;
    data['data'] = this.data;
    return data;
  }
}
