import 'package:xuriti/util/Extensions.dart';

class Credit_Details_View_Model {
  String? message;
  CompanyDetails? companyDetails;
  bool? status;
  int? errorCode;

  Credit_Details_View_Model(
      {this.message, this.companyDetails, this.status, this.errorCode});

  Credit_Details_View_Model.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    companyDetails = json['company_details'] != null
        ? new CompanyDetails.fromJson(json['company_details'])
        : null;
    status = json['status'];
    errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.companyDetails != null) {
      data['company_details'] = this.companyDetails!.toJson();
    }
    data['status'] = this.status;
    data['errorCode'] = this.errorCode;
    return data;
  }
}

class CompanyDetails {
  String? businessName;
  String? businessGstin;
  bool? sellerFlage;
  double? totalCreditAvailable;
  double? totalCreditLimit;
  List<CreditDetails>? creditDetails;

  CompanyDetails(
      {this.businessName,
      this.businessGstin,
      this.sellerFlage,
      this.totalCreditAvailable,
      this.totalCreditLimit,
      this.creditDetails});

  CompanyDetails.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
    businessGstin = json['business_gstin'];
    sellerFlage = json['seller_flage'];
    totalCreditAvailable =
        json['total_credit_available'].toString().getDoubleValue();
    totalCreditLimit = json['total_credit_limit'].toString().getDoubleValue();
    if (json['credit_details'] != null) {
      creditDetails = <CreditDetails>[];
      json['credit_details'].forEach((v) {
        creditDetails!.add(new CreditDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_name'] = this.businessName;
    data['business_gstin'] = this.businessGstin;
    data['seller_flage'] = this.sellerFlage;
    data['total_credit_available'] = this.totalCreditAvailable;
    data['total_credit_limit'] = this.totalCreditLimit;
    if (this.creditDetails != null) {
      data['credit_details'] =
          this.creditDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreditDetails {
  String? anchorName;
  String? anchorGstin;
  String? address;
  String? creditLimit;
  String? creditAvailable;
  String? anchor_pan;
  String? Anchor_id;

  CreditDetails({
    this.anchorName,
    this.anchorGstin,
    this.address,
    this.creditLimit,
    this.creditAvailable,
    this.anchor_pan,
    this.Anchor_id,
  });

  CreditDetails.fromJson(Map<String, dynamic> json) {
    anchorName = json['anchor_name'];
    anchor_pan = json["anchor_pan"];
    anchorGstin = json['Anchor_gstin'];
    address = json['address'];
    creditLimit = json['credit_limit'];
    creditAvailable = json['credit_available'];
    Anchor_id = json["Anchor_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['anchor_name'] = this.anchorName;
    data["anchor_pan"] = this.anchor_pan;
    data['Anchor_gstin'] = this.anchorGstin;
    data['address'] = this.address;
    data['credit_limit'] = this.creditLimit;
    data['credit_available'] = this.creditAvailable;
    data["Anchor_id"] = this.Anchor_id;
    return data;
  }
}
