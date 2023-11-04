class KYCStatusModel {
  Data? data;
  bool? status;

  KYCStatusModel({this.data, this.status});

  KYCStatusModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Data {
  Pan? pan;
  Aadhar? aadhar;
  Mobile? mobile;
  FaceMatch? faceMatch;
  Address? address;
  BankStatement? bankStatement;
  Business? business;
  Residence? residence;
  Address? financial;
  Address? gst;
  Ownership? ownership;
  Address? partnership;
  Vintage? vintage;
  Address? storeImages;
  Address? chequeImages;
  FaceMatch? udyogAadhar;

  Data(
      {this.pan,
      this.aadhar,
      this.mobile,
      this.faceMatch,
      this.address,
      this.bankStatement,
      this.business,
      this.residence,
      this.financial,
      this.gst,
      this.ownership,
      this.partnership,
      this.vintage,
      this.storeImages,
      this.chequeImages,
      this.udyogAadhar});

  Data.fromJson(Map<String, dynamic> json) {
    pan = json['pan'] != null ? new Pan.fromJson(json['pan']) : null;
    aadhar =
        json['aadhar'] != null ? new Aadhar.fromJson(json['aadhar']) : null;
    mobile =
        json['mobile'] != null ? new Mobile.fromJson(json['mobile']) : null;
    faceMatch = json['faceMatch'] != null
        ? new FaceMatch.fromJson(json['faceMatch'])
        : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    bankStatement = json['bankStatement'] != null
        ? new BankStatement.fromJson(json['bankStatement'])
        : null;
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
    residence = json['residence'] != null
        ? new Residence.fromJson(json['residence'])
        : null;
    financial = json['financial'] != null
        ? new Address.fromJson(json['financial'])
        : null;
    gst = json['gst'] != null ? new Address.fromJson(json['gst']) : null;
    ownership = json['ownership'] != null
        ? new Ownership.fromJson(json['ownership'])
        : null;
    partnership = json['partnership'] != null
        ? new Address.fromJson(json['partnership'])
        : null;
    vintage =
        json['vintage'] != null ? new Vintage.fromJson(json['vintage']) : null;
    storeImages = json['storeImages'] != null
        ? new Address.fromJson(json['storeImages'])
        : null;
    chequeImages = json['chequeImages'] != null
        ? new Address.fromJson(json['chequeImages'])
        : null;
    udyogAadhar = json['udyogAadhar'] != null
        ? new FaceMatch.fromJson(json['udyogAadhar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pan != null) {
      data['pan'] = this.pan!.toJson();
    }
    if (this.aadhar != null) {
      data['aadhar'] = this.aadhar!.toJson();
    }
    if (this.mobile != null) {
      data['mobile'] = this.mobile!.toJson();
    }
    if (this.faceMatch != null) {
      data['faceMatch'] = this.faceMatch!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.bankStatement != null) {
      data['bankStatement'] = this.bankStatement!.toJson();
    }
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    if (this.residence != null) {
      data['residence'] = this.residence!.toJson();
    }
    if (this.financial != null) {
      data['financial'] = this.financial!.toJson();
    }
    if (this.gst != null) {
      data['gst'] = this.gst!.toJson();
    }
    if (this.ownership != null) {
      data['ownership'] = this.ownership!.toJson();
    }
    if (this.partnership != null) {
      data['partnership'] = this.partnership!.toJson();
    }
    if (this.vintage != null) {
      data['vintage'] = this.vintage!.toJson();
    }
    if (this.storeImages != null) {
      data['storeImages'] = this.storeImages!.toJson();
    }
    if (this.chequeImages != null) {
      data['chequeImages'] = this.chequeImages!.toJson();
    }
    if (this.udyogAadhar != null) {
      data['udyogAadhar'] = this.udyogAadhar!.toJson();
    }
    return data;
  }
}

class Pan {
  bool? verified;
  String? status;
  String? signzyStatus;
  String? comment;
  String? holder;
  String? number;
  List<FilesData>? files;

  Pan(
      {this.verified,
      this.status,
      this.signzyStatus,
      this.comment,
      this.holder,
      this.number,
      this.files});

  Pan.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    status = json['status'];
    signzyStatus = json['signzyStatus'];
    comment = json['comment'];
    holder = json['holder'];
    number = json['number'];
    if (json['files'] != null) {
      files = <FilesData>[];
      json['files'].forEach((v) {
        files!.add(new FilesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['status'] = this.status;
    data['signzyStatus'] = this.signzyStatus;
    data['comment'] = this.comment;
    data['holder'] = this.holder;
    data['number'] = this.number;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FilesData {
  String? url;
  String? createdBy;
  String? createdAt;
  String? documentType;
  String? documentName;

  FilesData(
      {this.url,
      this.createdBy,
      this.createdAt,
      this.documentType,
      this.documentName});

  FilesData.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    createdBy = json['createdBy'];
    createdAt = json['createdAt'];
    documentType = json['document_type'];
    documentName = json['document_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['createdBy'] = this.createdBy;
    data['createdAt'] = this.createdAt;
    data['document_type'] = this.documentType;
    data['document_name'] = this.documentName;
    return data;
  }
}

class Aadhar {
  bool? verified;
  String? status;
  String? signzyStatus;
  String? comment;
  String? holder;
  String? number;
  String? address;
  String? dob;
  String? gender;
  List<FilesData>? files;

  Aadhar(
      {this.verified,
      this.status,
      this.signzyStatus,
      this.comment,
      this.holder,
      this.number,
      this.address,
      this.dob,
      this.gender,
      this.files});

  Aadhar.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    status = json['status'];
    signzyStatus = json['signzyStatus'];
    comment = json['comment'];
    holder = json['holder'];
    number = json['number'];
    address = json['address'];
    dob = json['dob'];
    gender = json['gender'];
    if (json['files'] != null) {
      files = <FilesData>[];
      json['files'].forEach((v) {
        files!.add(new FilesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['status'] = this.status;
    data['signzyStatus'] = this.signzyStatus;
    data['comment'] = this.comment;
    data['holder'] = this.holder;
    data['number'] = this.number;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Files {
  String? url;
  String? createdBy;
  String? documentType;
  String? documentName;

  Files({this.url, this.createdBy, this.documentType, this.documentName});

  Files.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    createdBy = json['createdBy'];
    documentType = json['document_type'];
    documentName = json['document_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['createdBy'] = this.createdBy;
    data['document_type'] = this.documentType;
    data['document_name'] = this.documentName;
    return data;
  }
}

class Mobile {
  bool? verified;
  String? status;
  String? signzyStatus;
  String? comment;
  String? number;
  String? countryCode;
  String? holder;
  String? address;
  String? email;
  String? createdAt;
  String? createdBy;

  Mobile(
      {this.verified,
      this.status,
      this.signzyStatus,
      this.comment,
      this.number,
      this.countryCode,
      this.holder,
      this.address,
      this.email,
      this.createdAt,
      this.createdBy});

  Mobile.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    status = json['status'];
    signzyStatus = json['signzyStatus'];
    comment = json['comment'];
    number = json['number'];
    countryCode = json['countryCode'];
    holder = json['holder'];
    address = json['address'];
    email = json['email'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['status'] = this.status;
    data['signzyStatus'] = this.signzyStatus;
    data['comment'] = this.comment;
    data['number'] = this.number;
    data['countryCode'] = this.countryCode;
    data['holder'] = this.holder;
    data['address'] = this.address;
    data['email'] = this.email;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    return data;
  }
}

class FaceMatch {
  bool? verified;
  String? status;

  FaceMatch({this.verified, this.status});

  FaceMatch.fromJson(Map<String, dynamic> json) {
    verified = json['verified'] != null
        ? ((json['verified'] is String) == true
            ? (json['verified'].toString() == "true" ? true : false)
            : json['verified'])
        : false;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verified'] = this.verified;
    data['status'] = this.status;
    return data;
  }
}

class Address {
  String? status;
  bool? verified;
  List<FilesData>? files;

  Address({this.status, this.verified, this.files});

  Address.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    verified = json['verified'];
    if (json['files'] != null) {
      files = <FilesData>[];
      json['files'].forEach((v) {
        files!.add(new FilesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['verified'] = this.verified;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankStatement {
  List<String>? password;
  String? status;
  bool? verified;
  List<FilesData>? files;

  BankStatement({this.password, this.status, this.verified, this.files});

  BankStatement.fromJson(Map<String, dynamic> json) {
    password =
        json['password'] != null ? json['password'].cast<String>() : null;
    status = json['status'];
    verified = json['verified'];
    if (json['files'] != null) {
      files = <FilesData>[];
      json['files'].forEach((v) {
        files!.add(new FilesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['status'] = this.status;
    data['verified'] = this.verified;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Business {
  String? documentNumber;
  String? documentType;
  String? status;
  String? comment;
  bool? verified;
  List<FilesData>? files;

  Business(
      {this.documentNumber,
      this.documentType,
      this.status,
      this.comment,
      this.verified,
      this.files});

  Business.fromJson(Map<String, dynamic> json) {
    documentNumber = json['documentNumber'];
    documentType = json['documentType'];
    status = json['status'];
    comment = json['comment'];
    verified = json['verified'];
    if (json['files'] != null) {
      files = <FilesData>[];
      json['files'].forEach((v) {
        files!.add(new FilesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentNumber'] = this.documentNumber;
    data['documentType'] = this.documentType;
    data['status'] = this.status;
    data['comment'] = this.comment;
    data['verified'] = this.verified;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Residence {
  String? documentType;
  String? status;
  bool? verified;
  List<FilesData>? files;

  Residence({this.documentType, this.status, this.verified, this.files});

  Residence.fromJson(Map<String, dynamic> json) {
    documentType = json['documentType'];
    status = json['status'];
    verified = json['verified'];
    if (json['files'] != null) {
      files = <FilesData>[];
      json['files'].forEach((v) {
        files!.add(new FilesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['documentType'] = this.documentType;
    data['status'] = this.status;
    data['verified'] = this.verified;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ownership {
  String? status;
  String? documentNumber;
  String? documentType;
  bool? verified;
  List<FilesData>? files;

  Ownership(
      {this.status,
      this.documentNumber,
      this.documentType,
      this.verified,
      this.files});

  Ownership.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    documentNumber = json['documentNumber'];
    documentType = json['documentType'];
    verified = json['verified'];
    if (json['files'] != null) {
      files = <FilesData>[];
      json['files'].forEach((v) {
        files!.add(new FilesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['documentNumber'] = this.documentNumber;
    data['documentType'] = this.documentType;
    data['verified'] = this.verified;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vintage {
  String? status;
  String? documentType;
  String? comment;
  bool? verified;
  List<FilesData>? files;

  Vintage(
      {this.status,
      this.documentType,
      this.comment,
      this.verified,
      this.files});

  Vintage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    documentType = json['documentType'];
    comment = json['comment'];
    verified = json['verified'];
    if (json['files'] != null) {
      files = <FilesData>[];
      json['files'].forEach((v) {
        files!.add(new FilesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['documentType'] = this.documentType;
    data['comment'] = this.comment;
    data['verified'] = this.verified;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
