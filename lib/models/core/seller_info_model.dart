import 'package:xuriti/util/Extensions.dart';

class SellerInfo {
  SellerInfo({
    required this.invoiceDetails,
    required this.status,
    required this.totalInterest,
    required this.totalOutstanding,
    required this.totalDiscount,
    required this.totalGst,
    required this.totalPayable,
    required this.settledAmount,
    required this.panNo,
  });

  final List<InvoiceDetail> invoiceDetails;
  final bool? status;
  final double? totalInterest;
  final double? totalOutstanding;
  final double? totalDiscount;
  final double? totalGst;
  final double? totalPayable;
  final double? settledAmount;
  String? panNo;

  factory SellerInfo.fromJson(Map<String, dynamic> json) {
    return SellerInfo(
      invoiceDetails: json["invoiceDetails"] == null
          ? []
          : List<InvoiceDetail>.from(
              json["invoiceDetails"]!.map((x) => InvoiceDetail.fromJson(x))),
      status: json["status"],
      totalInterest: json["total_interest"].toString().getDoubleValue(),
      totalOutstanding: json["total_outstanding"].toString().getDoubleValue(),
      totalDiscount: json["total_discount"].toString().getDoubleValue(),
      totalGst: json["total_gst"].toString().getDoubleValue(),
      totalPayable: json["total_payable"].toString().getDoubleValue(),
      settledAmount: json["settled_amount"].toString().getDoubleValue(),
      panNo: "",
    );
  }

  Map<String, dynamic> toJson() => {
        "invoiceDetails": invoiceDetails.map((x) => x.toJson()).toList(),
        "status": status,
        "total_interest": totalInterest,
        "total_outstanding": totalOutstanding,
        "total_discount": totalDiscount,
        "total_gst": totalGst,
        "total_payable": totalPayable,
        "settled_amount": settledAmount,
      };
}

class InvoiceDetail {
  InvoiceDetail({
    required this.id,
    required this.interest,
    required this.invoiceNumber,
    required this.discount,
    required this.gst,
    required this.amountCleared,
    required this.outstandingAmount,
    required this.remainingOutstanding,
  });

  final String? id;
  final double? interest;
  final String? invoiceNumber;
  final double? discount;
  final double? gst;
  final double? amountCleared;
  final double? outstandingAmount;
  final double? remainingOutstanding;

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) {
    return InvoiceDetail(
      id: json["_id"],
      interest: json["interest"].toString().getDoubleValue(),
      invoiceNumber: json["invoice_number"],
      discount: json["discount"].toString().getDoubleValue(),
      gst: json["gst"].toString().getDoubleValue(),
      amountCleared: json["amount_cleared"].toString().getDoubleValue(),
      outstandingAmount: json["outstanding_amount"].toString().getDoubleValue(),
      remainingOutstanding:
          json["remaining_outstanding"].toString().getDoubleValue(),
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "interest": interest,
        "invoice_number": invoiceNumber,
        "discount": discount,
        "gst": gst,
        "amount_cleared": amountCleared,
        "outstanding_amount": outstandingAmount,
        "remaining_outstanding": remainingOutstanding,
      };
}
