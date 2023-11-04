import 'package:xuriti/util/Extensions.dart';

class CompanyListModel {
  bool? status;
  List<CompanyData>? company;

  CompanyListModel({this.status, this.company});

  CompanyListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['company'] != null) {
      company = <CompanyData>[];
      json['company'].forEach((v) {
        company!.add(new CompanyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.company != null) {
      data['company'] = this.company!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CompanyData {
  String? sId;
  String? user;
  CompanyInformation? company;
  String? userRole;
  int? iV;

  CompanyData({this.sId, this.user, this.company, this.userRole, this.iV});

  CompanyData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    company = json['company'] != null
        ? new CompanyInformation.fromJson(json['company'])
        : null;
    userRole = json['userRole'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['user'] = this.user;
    if (this.company != null) {
      data['company'] = this.company!.toJson();
    }
    data['userRole'] = this.userRole;
    data['__v'] = this.iV;
    return data;
  }
}

class CompanyInformation {
  Cih? cih;
  Metadata? metadata;
  String? companyId;
  bool? softDelete;
  bool? nbfcApproved;
  String? sId;
  String? gstin;
  String? companyName;
  String? address;
  String? district;
  String? state;
  bool? eNachMandate;
  int? companyMobile;
  String? companyEmail;
  String? pan;
  String? status;
  // String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? adminMobile;
  String? adminEmail;
  String? adminName;
  int? creditLimit;
  double? availCredit;
  double? optimizecredit;
  bool? kyc;
  bool? kycDocumentUpload;
  bool? consentFlag;
  bool? waNotifications;
  double? previousCredit;
  String? xuritiScore;
  String? temporaryCredit;

  int? iV;
  String? presignedurl;
  String? annualTurnover;
  String? industryType;
  String? interest;
  String? pincode;
  List<AssociatedSeller>? associatedSeller;
  bool? sellerFlag;
  String? latitude;
  String? longitude;
  String? kycCount;

  CompanyInformation(
      {this.cih,
      this.companyId,
      this.metadata,
      this.softDelete,
      this.nbfcApproved,
      this.sId,
      this.gstin,
      this.companyName,
      this.address,
      this.district,
      this.state,
      this.eNachMandate,
      this.companyMobile,
      this.companyEmail,
      this.pan,
      this.status,
      // this.createdBy,
      this.createdAt,
      this.updatedAt,
      this.adminMobile,
      this.adminEmail,
      this.adminName,
      this.creditLimit,
      this.availCredit,
      this.optimizecredit,
      this.kyc,
      this.kycDocumentUpload,
      this.consentFlag,
      this.waNotifications,
      this.previousCredit,
      this.xuritiScore,
      this.temporaryCredit,
      this.iV,
      this.presignedurl,
      this.annualTurnover,
      this.industryType,
      this.interest,
      this.pincode,
      this.associatedSeller,
      this.sellerFlag,
      this.latitude,
      this.longitude,
      this.kycCount});

  CompanyInformation.fromJson(Map<String, dynamic> json) {
    cih = json['cih'] != null ? new Cih.fromJson(json['cih']) : null;
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    companyId = json['_id'];
    softDelete = json['soft_delete'];
    nbfcApproved = json['nbfc_approved'];
    sId = json['_id'];
    gstin = json['gstin'];
    companyName = json['company_name'];
    address = json['address'];
    district = json['district'];
    state = json['state'];
    eNachMandate = json['eNachMandate'];
    companyMobile = json['company_mobile'];
    companyEmail = json['company_email'];
    pan = json['pan'];
    status = json['status'];
    // createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    adminMobile = json['admin_mobile'];
    adminEmail = json['admin_email'];
    adminName = json['admin_name'];
    creditLimit = json['creditLimit'];
    availCredit = (json['avail_credit']).toString().getDoubleValue();
    optimizecredit = (json['optimizecredit']).toString().getDoubleValue();
    kyc = json['kyc'];
    kycDocumentUpload = json['kyc_document_upload'];
    consentFlag = json['consent_flag'];
    waNotifications = json['wa_notifications'];
    previousCredit = json['previous_credit'] != null
        ? json['previous_credit'].toString().getDoubleValue()
        : 0.0;
    xuritiScore = json['xuriti_score'];
    temporaryCredit = json['temporary_credit'] != null
        ? json['temporary_credit'].toString()
        : "0.0";

    iV = json['__v'];
    presignedurl = json['presignedurl'];
    annualTurnover = json['annual_turnover'];
    industryType = json['industry_type'];
    interest = json['interest'];
    pincode = json['pincode'];
    if (json['associated_seller'] != null) {
      associatedSeller = <AssociatedSeller>[];
      json['associated_seller'].forEach((v) {
        associatedSeller!.add(new AssociatedSeller.fromJson(v));
      });
    }
    sellerFlag = json['seller_flag'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    kycCount = json['kyc_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cih != null) {
      data['cih'] = this.cih!.toJson();
    }
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }

    data['soft_delete'] = this.softDelete;
    data['nbfc_approved'] = this.nbfcApproved;
    data['_id'] = this.sId;
    data['gstin'] = this.gstin;
    data['company_name'] = this.companyName;
    data['address'] = this.address;
    data['district'] = this.district;
    data['state'] = this.state;
    data['eNachMandate'] = this.eNachMandate;
    data['company_mobile'] = this.companyMobile;
    data['company_email'] = this.companyEmail;
    data['pan'] = this.pan;
    data['status'] = this.status;
    // data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['admin_mobile'] = this.adminMobile;
    data['admin_email'] = this.adminEmail;
    data['admin_name'] = this.adminName;
    data['creditLimit'] = this.creditLimit;
    data['avail_credit'] = this.availCredit;
    data['optimizecredit'] = this.optimizecredit;
    data['kyc'] = this.kyc;
    data['kyc_document_upload'] = this.kycDocumentUpload;
    data['consent_flag'] = this.consentFlag;
    data['wa_notifications'] = this.waNotifications;
    data['previous_credit'] = this.previousCredit;
    data['xuriti_score'] = this.xuritiScore;
    data['temporary_credit'] = this.temporaryCredit;
    data['__v'] = this.iV;
    data['presignedurl'] = this.presignedurl;
    data['annual_turnover'] = this.annualTurnover;
    data['industry_type'] = this.industryType;
    data['interest'] = this.interest;
    data['pincode'] = this.pincode;
    if (this.associatedSeller != null) {
      data['associated_seller'] =
          this.associatedSeller!.map((v) => v.toJson()).toList();
    }
    data['seller_flag'] = this.sellerFlag;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['kyc_count'] = this.kycCount;
    return data;
  }
}

class Cih {
  double? amount;
  String? updatedby;
  String? lastupdatedon;

  Cih({this.amount, this.updatedby, this.lastupdatedon});

  Cih.fromJson(Map<String, dynamic> json) {
    amount = json['amount'].toString().getDoubleValue();
    updatedby = json['updatedby'];
    lastupdatedon = json['lastupdatedon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['updatedby'] = this.updatedby;
    data['lastupdatedon'] = this.lastupdatedon;
    return data;
  }
}

class Metadata {
  bool? esignStatus;
  List<Comments>? comments;
  List<AuditTrail>? auditTrail;

  Metadata({this.esignStatus, this.comments, this.auditTrail});

  Metadata.fromJson(Map<String, dynamic> json) {
    esignStatus = json['esign_status'];
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    if (json['audit_trail'] != null) {
      auditTrail = <AuditTrail>[];
      json['audit_trail'].forEach((v) {
        auditTrail!.add(new AuditTrail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['esign_status'] = this.esignStatus;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    if (this.auditTrail != null) {
      data['audit_trail'] = this.auditTrail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Comments {
  String? timeStamp;
  String? postedBy;
  String? comment;
  String? sId;
  String? commentCategory;

  Comments(
      {this.timeStamp,
      this.postedBy,
      this.comment,
      this.sId,
      this.commentCategory});

  Comments.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'];
    postedBy = json['postedBy'];
    comment = json['comment'];
    sId = json['_id'];
    commentCategory = json['comment_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeStamp'] = this.timeStamp;
    data['postedBy'] = this.postedBy;
    data['comment'] = this.comment;
    data['_id'] = this.sId;
    data['comment_category'] = this.commentCategory;
    return data;
  }
}

class AuditTrail {
  String? timeStamp;
  String? userId;
  String? userIp;
  String? action;
  String? sId;

  AuditTrail({this.timeStamp, this.userId, this.userIp, this.action, this.sId});

  AuditTrail.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'];
    userId = json['userId'];
    userIp = json['userIp'];
    action = json['action'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeStamp'] = this.timeStamp;
    data['userId'] = this.userId;
    data['userIp'] = this.userIp;
    data['action'] = this.action;
    data['_id'] = this.sId;
    return data;
  }
}

class AssociatedSeller {
  String? sellerId;
  String? sellerName;
  String? sId;

  AssociatedSeller({this.sellerId, this.sellerName, this.sId});

  AssociatedSeller.fromJson(Map<String, dynamic> json) {
    sellerId = json['seller_id'];
    sellerName = json['seller_name'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seller_id'] = this.sellerId;
    data['seller_name'] = this.sellerName;
    data['_id'] = this.sId;
    return data;
  }
}
