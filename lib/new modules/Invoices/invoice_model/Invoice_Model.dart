class Invoice_Model {
  bool? status;
  int? totalOutstandingAmount;
  List<Invoice>? invoice;

  Invoice_Model({this.status, this.totalOutstandingAmount, this.invoice});

  Invoice_Model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalOutstandingAmount = json['totalOutstandingAmount'];
    if (json['invoice'] != null) {
      invoice = <Invoice>[];
      json['invoice'].forEach((v) {
        invoice!.add(new Invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalOutstandingAmount'] = this.totalOutstandingAmount;
    if (this.invoice != null) {
      data['invoice'] = this.invoice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invoice {
  BillDetails? billDetails;
  int? paidInterest;
  int? paidDiscount;
  int? taxPaid;
  String? sId;
  String? invoiceNumber;
  int? outstandingAmount;
  String? invoiceStatus;
  String? extraCreditFlag;
  String? buyerGst;
  String? sellerGst;
  String? updatedAt;
  Buyer? buyer;
  String? invoiceAmount;
  int? paidAmount;
  String? invoiceDate;
  String? invoiceDueDate;
  Seller? seller;
  int? taxUnpaid;
  CreditPlan? creditPlan;
  bool? userConsentGiven;
  String? nbfcName;
  String? createdAt;
  double? interest;
  int? discount;
  Metadata? metadata;
  String? invoiceType;
  String? invoiceFile;
  bool? acknowledgementFlag;

  Invoice(
      {this.billDetails,
      this.paidInterest,
      this.paidDiscount,
      this.taxPaid,
      this.sId,
      this.invoiceNumber,
      this.outstandingAmount,
      this.invoiceStatus,
      this.extraCreditFlag,
      this.buyerGst,
      this.sellerGst,
      this.updatedAt,
      this.buyer,
      this.invoiceAmount,
      this.paidAmount,
      this.invoiceDate,
      this.invoiceDueDate,
      this.seller,
      this.taxUnpaid,
      this.creditPlan,
      this.userConsentGiven,
      this.nbfcName,
      this.createdAt,
      this.interest,
      this.discount,
      this.metadata,
      this.invoiceType,
      this.invoiceFile,
      this.acknowledgementFlag});

  Invoice.fromJson(Map<String, dynamic> json) {
    billDetails = json['bill_details'] != null
        ? new BillDetails.fromJson(json['bill_details'])
        : null;
    paidInterest = json['paid_interest'];
    paidDiscount = json['paid_discount'];
    taxPaid = json['tax_paid'];
    sId = json['_id'];
    invoiceNumber = json['invoice_number'];
    outstandingAmount = json['outstanding_amount'];
    invoiceStatus = json['invoice_status'];
    extraCreditFlag = json['extra_credit_flag'];
    buyerGst = json['buyer_gst'];
    sellerGst = json['seller_gst'];
    updatedAt = json['updatedAt'];
    buyer = json['buyer'] != null ? new Buyer.fromJson(json['buyer']) : null;
    invoiceAmount = json['invoice_amount'];
    paidAmount = json['paid_amount'];
    invoiceDate = json['invoice_date'];
    invoiceDueDate = json['invoice_due_date'];
    seller =
        json['seller'] != null ? new Seller.fromJson(json['seller']) : null;
    taxUnpaid = json['tax_unpaid'];
    creditPlan = json['credit_plan'] != null
        ? new CreditPlan.fromJson(json['credit_plan'])
        : null;
    userConsentGiven = json['userConsentGiven'];
    nbfcName = json['nbfc_name'];
    createdAt = json['createdAt'];
    interest = json['interest'];
    discount = json['discount'];
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    invoiceType = json['invoice_type'];
    invoiceFile = json['invoice_file'];
    acknowledgementFlag = json['acknowledgement_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.billDetails != null) {
      data['bill_details'] = this.billDetails!.toJson();
    }
    data['paid_interest'] = this.paidInterest;
    data['paid_discount'] = this.paidDiscount;
    data['tax_paid'] = this.taxPaid;
    data['_id'] = this.sId;
    data['invoice_number'] = this.invoiceNumber;
    data['outstanding_amount'] = this.outstandingAmount;
    data['invoice_status'] = this.invoiceStatus;
    data['extra_credit_flag'] = this.extraCreditFlag;
    data['buyer_gst'] = this.buyerGst;
    data['seller_gst'] = this.sellerGst;
    data['updatedAt'] = this.updatedAt;
    if (this.buyer != null) {
      data['buyer'] = this.buyer!.toJson();
    }
    data['invoice_amount'] = this.invoiceAmount;
    data['paid_amount'] = this.paidAmount;
    data['invoice_date'] = this.invoiceDate;
    data['invoice_due_date'] = this.invoiceDueDate;
    if (this.seller != null) {
      data['seller'] = this.seller!.toJson();
    }
    data['tax_unpaid'] = this.taxUnpaid;
    if (this.creditPlan != null) {
      data['credit_plan'] = this.creditPlan!.toJson();
    }
    data['userConsentGiven'] = this.userConsentGiven;
    data['nbfc_name'] = this.nbfcName;
    data['createdAt'] = this.createdAt;
    data['interest'] = this.interest;
    data['discount'] = this.discount;
    if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
    data['invoice_type'] = this.invoiceType;
    data['invoice_file'] = this.invoiceFile;
    data['acknowledgement_flag'] = this.acknowledgementFlag;
    return data;
  }
}

class BillDetails {
  GstSummary? gstSummary;

  BillDetails({this.gstSummary});

  BillDetails.fromJson(Map<String, dynamic> json) {
    gstSummary = json['gst_summary'] != null
        ? new GstSummary.fromJson(json['gst_summary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gstSummary != null) {
      data['gst_summary'] = this.gstSummary!.toJson();
    }
    return data;
  }
}

class GstSummary {
  String? totalTax;

  GstSummary({this.totalTax});

  GstSummary.fromJson(Map<String, dynamic> json) {
    totalTax = json['total_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_tax'] = this.totalTax;
    return data;
  }
}

class Buyer {
  Cih? cih;
  Metadata? metadata;
  bool? softDelete;
  bool? nbfcApproved;
  String? sId;
  String? gstin;
  String? companyName;
  String? address;
  String? district;
  String? state;
  bool? eNachMandate;
  String? pincode;
  int? companyMobile;
  String? companyEmail;
  String? pan;
  String? status;
  String? createdBy;
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
  int? previousCredit;
  String? xuritiScore;
  String? temporaryCredit;
  int? iV;
  String? presignedurl;
  String? annualTurnover;
  String? industryType;
  String? interest;
  List<AssociatedSeller>? associatedSeller;
  bool? sellerFlag;
  String? kycCount;
  String? latitude;
  String? longitude;

  Buyer(
      {this.cih,
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
      this.pincode,
      this.companyMobile,
      this.companyEmail,
      this.pan,
      this.status,
      this.createdBy,
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
      this.associatedSeller,
      this.sellerFlag,
      this.kycCount,
      this.latitude,
      this.longitude});

  Buyer.fromJson(Map<String, dynamic> json) {
    cih = json['cih'] != null ? new Cih.fromJson(json['cih']) : null;
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    softDelete = json['soft_delete'];
    nbfcApproved = json['nbfc_approved'];
    sId = json['_id'];
    gstin = json['gstin'];
    companyName = json['company_name'];
    address = json['address'];
    district = json['district'];
    state = json['state'];
    eNachMandate = json['eNachMandate'];
    pincode = json['pincode'];
    companyMobile = json['company_mobile'];
    companyEmail = json['company_email'];
    pan = json['pan'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    adminMobile = json['admin_mobile'];
    adminEmail = json['admin_email'];
    adminName = json['admin_name'];
    creditLimit = json['creditLimit'];
    availCredit = json['avail_credit'];
    optimizecredit = json['optimizecredit'];
    kyc = json['kyc'];
    kycDocumentUpload = json['kyc_document_upload'];
    consentFlag = json['consent_flag'];
    waNotifications = json['wa_notifications'];
    previousCredit = json['previous_credit'];
    xuritiScore = json['xuriti_score'];
    temporaryCredit = json['temporary_credit'];
    iV = json['__v'];
    presignedurl = json['presignedurl'];
    annualTurnover = json['annual_turnover'];
    industryType = json['industry_type'];
    interest = json['interest'];
    if (json['associated_seller'] != null) {
      associatedSeller = <AssociatedSeller>[];
      json['associated_seller'].forEach((v) {
        associatedSeller!.add(new AssociatedSeller.fromJson(v));
      });
    }
    sellerFlag = json['seller_flag'];
    kycCount = json['kyc_count'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    data['pincode'] = this.pincode;
    data['company_mobile'] = this.companyMobile;
    data['company_email'] = this.companyEmail;
    data['pan'] = this.pan;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
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
    if (this.associatedSeller != null) {
      data['associated_seller'] =
          this.associatedSeller!.map((v) => v.toJson()).toList();
    }
    data['seller_flag'] = this.sellerFlag;
    data['kyc_count'] = this.kycCount;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Cih {
  int? amount;
  String? updatedby;

  Cih({this.amount, this.updatedby});

  Cih.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    updatedby = json['updatedby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['updatedby'] = this.updatedby;
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

  Comments({this.timeStamp, this.postedBy, this.comment, this.sId});

  Comments.fromJson(Map<String, dynamic> json) {
    timeStamp = json['timeStamp'];
    postedBy = json['postedBy'];
    comment = json['comment'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeStamp'] = this.timeStamp;
    data['postedBy'] = this.postedBy;
    data['comment'] = this.comment;
    data['_id'] = this.sId;
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

class Seller {
  Metadata? metadata;
  bool? softDelete;
  bool? nbfcApproved;
  String? sId;
  String? gstin;
  String? companyName;
  String? address;
  String? district;
  String? state;
  bool? eNachMandate;
  String? pincode;
  int? companyMobile;
  String? companyEmail;
  String? pan;
  String? status;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  String? adminMobile;
  String? adminEmail;
  String? adminName;
  int? creditLimit;
  int? availCredit;
  int? optimizecredit;
  bool? kyc;
  bool? kycDocumentUpload;
  bool? consentFlag;
  bool? waNotifications;
  int? previousCredit;
  String? xuritiScore;
  String? temporaryCredit;
  int? iV;
  String? presignedurl;
  String? annualTurnover;
  String? industryType;
  String? interest;
  bool? sellerFlag;
  String? kycCount;

  Seller(
      {this.metadata,
      this.softDelete,
      this.nbfcApproved,
      this.sId,
      this.gstin,
      this.companyName,
      this.address,
      this.district,
      this.state,
      this.eNachMandate,
      this.pincode,
      this.companyMobile,
      this.companyEmail,
      this.pan,
      this.status,
      this.createdBy,
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
      this.sellerFlag,
      this.kycCount});

  Seller.fromJson(Map<String, dynamic> json) {
    metadata = json['metadata'] != null
        ? new Metadata.fromJson(json['metadata'])
        : null;
    softDelete = json['soft_delete'];
    nbfcApproved = json['nbfc_approved'];
    sId = json['_id'];
    gstin = json['gstin'];
    companyName = json['company_name'];
    address = json['address'];
    district = json['district'];
    state = json['state'];
    eNachMandate = json['eNachMandate'];
    pincode = json['pincode'];
    companyMobile = json['company_mobile'];
    companyEmail = json['company_email'];
    pan = json['pan'];
    status = json['status'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    adminMobile = json['admin_mobile'];
    adminEmail = json['admin_email'];
    adminName = json['admin_name'];
    creditLimit = json['creditLimit'];
    availCredit = json['avail_credit'];
    optimizecredit = json['optimizecredit'];
    kyc = json['kyc'];
    kycDocumentUpload = json['kyc_document_upload'];
    consentFlag = json['consent_flag'];
    waNotifications = json['wa_notifications'];
    previousCredit = json['previous_credit'];
    xuritiScore = json['xuriti_score'];
    temporaryCredit = json['temporary_credit'];
    iV = json['__v'];
    presignedurl = json['presignedurl'];
    annualTurnover = json['annual_turnover'];
    industryType = json['industry_type'];
    interest = json['interest'];
    sellerFlag = json['seller_flag'];
    kycCount = json['kyc_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['pincode'] = this.pincode;
    data['company_mobile'] = this.companyMobile;
    data['company_email'] = this.companyEmail;
    data['pan'] = this.pan;
    data['status'] = this.status;
    data['createdBy'] = this.createdBy;
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
    data['seller_flag'] = this.sellerFlag;
    data['kyc_count'] = this.kycCount;
    return data;
  }
}

class CreditPlan {
  String? sId;
  String? planName;
  int? creditPeriod;
  bool? defaultPlan;
  int? paymentInterval;
  List<DiscountSlabs>? discountSlabs;
  String? planType;
  String? sellerId;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  int? iV;

  CreditPlan(
      {this.sId,
      this.planName,
      this.creditPeriod,
      this.defaultPlan,
      this.paymentInterval,
      this.discountSlabs,
      this.planType,
      this.sellerId,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.iV});

  CreditPlan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planName = json['plan_name'];
    creditPeriod = json['credit_period'];
    defaultPlan = json['default_plan'];
    paymentInterval = json['payment_interval'];
    if (json['discount_slabs'] != null) {
      discountSlabs = <DiscountSlabs>[];
      json['discount_slabs'].forEach((v) {
        discountSlabs!.add(new DiscountSlabs.fromJson(v));
      });
    }
    planType = json['plan_type'];
    sellerId = json['seller_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    createdBy = json['createdBy'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['plan_name'] = this.planName;
    data['credit_period'] = this.creditPeriod;
    data['default_plan'] = this.defaultPlan;
    data['payment_interval'] = this.paymentInterval;
    if (this.discountSlabs != null) {
      data['discount_slabs'] =
          this.discountSlabs!.map((v) => v.toJson()).toList();
    }
    data['plan_type'] = this.planType;
    data['seller_id'] = this.sellerId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdBy'] = this.createdBy;
    data['__v'] = this.iV;
    return data;
  }
}

class DiscountSlabs {
  int? from;
  int? to;
  double? discount;
  String? sId;

  DiscountSlabs({this.from, this.to, this.discount, this.sId});

  DiscountSlabs.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    discount = json['discount'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['discount'] = this.discount;
    data['_id'] = this.sId;
    return data;
  }
}

// class Metadata {
//   List<AuditTrail>? auditTrail;
//   List<Comments>? comments;

//   Metadata({this.auditTrail, this.comments});

//   Metadata.fromJson(Map<String, dynamic> json) {
//     if (json['audit_trail'] != null) {
//       auditTrail = <AuditTrail>[];
//       json['audit_trail'].forEach((v) {
//         auditTrail!.add(new AuditTrail.fromJson(v));
//       });
//     }
//     if (json['comments'] != null) {
//       comments = <Comments>[];
//       json['comments'].forEach((v) {
//         comments!.add(new Comments.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.auditTrail != null) {
//       data['audit_trail'] = this.auditTrail!.map((v) => v.toJson()).toList();
//     }
//     if (this.comments != null) {
//       data['comments'] = this.comments!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
