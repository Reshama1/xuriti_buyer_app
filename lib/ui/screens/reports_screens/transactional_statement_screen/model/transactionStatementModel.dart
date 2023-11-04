import 'package:xuriti/util/Extensions.dart';

class TransactionStatementModel {
  TransactionStatementModel({
    required this.status,
    required this.transaction,
  });

  final bool? status;
  final List<TransactionStatement> transaction;

  factory TransactionStatementModel.fromJson(Map<String, dynamic> json) {
    return TransactionStatementModel(
      status: json["status"],
      transaction: json["transaction"] == null
          ? []
          : List<TransactionStatement>.from(json["transaction"]!
              .map((x) => TransactionStatement.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "transaction": transaction.map((x) => x.toJson()).toList(),
      };
}

class TransactionStatement {
  TransactionStatement({
    required this.account,
    required this.counterParty,
    required this.accountType,
    required this.recordType,
    required this.sellerGstin,
    required this.invoiceId,
    required this.invoiceDate,
    required this.transactionType,
    required this.transactionAmount,
    required this.debit,
    required this.credit,
    required this.balance,
    required this.transactionDate,
    required this.createdAt,
    required this.id,
  });

  final String? account;
  final String? counterParty;
  final String? accountType;
  final String? recordType;
  final String? sellerGstin;
  final String? invoiceId;
  final String? transactionType;
  final double? transactionAmount;
  final double? debit;
  final double? credit;
  final double? balance;
  final DateTime? transactionDate;
  final DateTime? createdAt;
  final DateTime? invoiceDate;
  final String? id;

  factory TransactionStatement.fromJson(Map<String, dynamic> json) {
    return TransactionStatement(
      account: json["account"],
      counterParty: json["counter_party"],
      accountType: json["account_type"],
      recordType: json["record_type"],
      sellerGstin: json["seller_gstin"],
      invoiceId: json["invoice_id"],
      invoiceDate: DateTime.tryParse(json["invoice_date"] ?? ""),
      transactionType: json["transaction_type"],
      transactionAmount:
          (json["transaction_amount"] ?? 0.0).toString().getDoubleValue(),
      debit: (json["debit"] ?? 0.0).toString().getDoubleValue(),
      credit: (json["credit"] ?? 0.0).toString().getDoubleValue(),
      balance: (json["balance"] ?? 0.0).toString().getDoubleValue(),
      transactionDate: DateTime.tryParse(json["transaction_date"] ?? ""),
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "account": account,
        "counter_party": counterParty,
        "account_type": accountType,
        "record_type": recordType,
        "seller_gstin": sellerGstin,
        "invoice_id": invoiceId,
        "transaction_type": transactionType,
        "transaction_amount": transactionAmount,
        "debit": debit,
        "credit": credit,
        "balance": balance,
        "transaction_date": transactionDate?.toIso8601String(),
        "invoice_date": invoiceDate?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "_id": id,
      };
}
