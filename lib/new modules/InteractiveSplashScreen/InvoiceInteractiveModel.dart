class InteractiveDialogModel {
  InteractiveData? message;
  bool? status;

  InteractiveDialogModel({this.message, this.status});

  InteractiveDialogModel.fromJson(Map<String, dynamic> json) {
    message = json['message'] != null && !(json["message"] is String)
        ? new InteractiveData.fromJson(json['message'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class InteractiveData {
  String? title;
  String? image;
  String? subtitle;
  String? actionButton;
  String? actionName;
  String? greet;

  InteractiveData(
      {this.title,
      this.image,
      this.subtitle,
      this.actionButton,
      this.actionName,
      this.greet});

  InteractiveData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['Image'];
    subtitle = json['Subtitle'];
    actionButton = json['Action_button'];
    actionName = json['Action_name'];
    greet = json["greet"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['Image'] = this.image;
    data['Subtitle'] = this.subtitle;
    data['Action_button'] = this.actionButton;
    data['Action_name'] = this.actionName;
    data["greet"] = this.greet;
    return data;
  }
}
