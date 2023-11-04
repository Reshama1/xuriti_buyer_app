import 'package:xuriti/util/Extensions.dart';

class PaymentHistoryModel {
  bool? status;
  int? count;
  List<Finalresult>? finalresult;
  String? message;

  PaymentHistoryModel(
      {this.status, this.count, this.finalresult, this.message});

  PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    if (json['finalresult'] != null) {
      finalresult = <Finalresult>[];
      json['finalresult'].forEach((v) {
        finalresult!.add(new Finalresult.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['count'] = this.count;
    if (this.finalresult != null) {
      data['finalresult'] = this.finalresult!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Finalresult {
  String? orderId;
  String? sellerName;
  String? retailerName;
  String? paymentDate;
  String? paymentMode;
  String? status;
  String? orderAmount;
  String? transactionId;
  String? comments;
  List<Invoices>? invoices;

  Finalresult(
      {this.orderId,
      this.sellerName,
      this.retailerName,
      this.paymentDate,
      this.paymentMode,
      this.status,
      this.orderAmount,
      this.transactionId,
      this.comments,
      this.invoices});

  Finalresult.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    sellerName = json['seller_name'];
    retailerName = json['retailer_name'];
    paymentDate = json['payment_date'];
    paymentMode = json['payment_mode'];
    status = json['status'];
    orderAmount =
        json['order_amount'] != null ? json['order_amount'].toString() : "0.0";
    transactionId = json['transaction_id'];
    comments = json['comments'];
    if (json['invoices'] != null) {
      invoices = <Invoices>[];
      json['invoices'].forEach((v) {
        invoices!.add(new Invoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['seller_name'] = this.sellerName;
    data['retailer_name'] = this.retailerName;
    data['payment_date'] = this.paymentDate;
    data['payment_mode'] = this.paymentMode;
    data['status'] = this.status;
    data['order_amount'] = this.orderAmount;
    data['transaction_id'] = this.transactionId;
    data['comments'] = this.comments;
    if (this.invoices != null) {
      data['invoices'] = this.invoices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Invoices {
  String? invoiceNumber;
  double? settledAmount;
  double? discount;
  double? interest;
  double? amountPaid;

  Invoices(
      {this.invoiceNumber,
      this.settledAmount,
      this.discount,
      this.interest,
      this.amountPaid});

  Invoices.fromJson(Map<String, dynamic> json) {
    invoiceNumber = json['invoice_number'];
    settledAmount = json['settled_amount'] != null
        ? json['settled_amount'].toString().getDoubleValue()
        : 0.0;
    discount = json['discount'] != null
        ? json['discount'].toString().getDoubleValue()
        : 0.0;
    interest = json['interest'] != null
        ? json['interest'].toString().getDoubleValue()
        : 0.0;
    amountPaid = json['amount_paid'] != null
        ? json['amount_paid'].toString().getDoubleValue()
        : 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_number'] = this.invoiceNumber;
    data['settled_amount'] = this.settledAmount;
    data['discount'] = this.discount;
    data['interest'] = this.interest;
    data['amount_paid'] = this.amountPaid;
    return data;
  }
}
