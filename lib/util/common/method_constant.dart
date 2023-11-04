import 'package:xuriti/util/Extensions.dart';

String getDueSinceAndOverDueTextForInvoices(
    {required String invoiceDate, required String invoiceDueDate}) {
  if (invoiceDueDate.isEmpty) {
    return "Due since ${(invoiceDate.getDateInRequiredFormat(requiredFormat: "yyyy-MM-dd HH:mm:ss")) != null ? DateTime.now().difference((invoiceDate.getDateInRequiredFormat(requiredFormat: "yyyy-MM-dd HH:mm:ss"))!).inDays.toString() + (DateTime.now().difference((invoiceDate.getDateInRequiredFormat(requiredFormat: "yyyy-MM-dd HH:mm:ss"))!).inDays >= 1 ? " days" : " day") : "0 day"} ";
  }

  return invoiceDueDate.getDateInRequiredFormat(
              requiredFormat: "yyyy-MM-dd HH:mm:ss") !=
          null
      ? (DateTime.now().isBefore(invoiceDueDate.getDateInRequiredFormat(
              requiredFormat: "yyyy-MM-dd HH:mm:ss")!)
          ? "Due since ${(invoiceDate.getDateInRequiredFormat(requiredFormat: "yyyy-MM-dd HH:mm:ss")) != null ? DateTime.now().difference((invoiceDate.getDateInRequiredFormat(requiredFormat: "yyyy-MM-dd HH:mm:ss"))!).inDays.toString() + (DateTime.now().difference((invoiceDate.getDateInRequiredFormat(requiredFormat: "yyyy-MM-dd HH:mm:ss"))!).inDays >= 1 ? " days" : " day") : "0 day"} "
          : " ${(invoiceDueDate.getDateInRequiredFormat(requiredFormat: "yyyy-MM-dd HH:mm:ss")) != null ? DateTime.now().difference((invoiceDueDate.getDateInRequiredFormat(requiredFormat: "yyyy-MM-dd HH:mm:ss"))!).inDays.toString() + (DateTime.now().difference((invoiceDueDate.getDateInRequiredFormat(requiredFormat: "yyyy-MM-dd HH:mm:ss"))!).inDays <= 1 ? " day overdue" : " days overdue") : ""} ")
      : "Due since ${(invoiceDate.getDateInRequiredFormat(requiredFormat: "yyyy-MM-dd HH:mm:ss")) != null ? DateTime.now().difference((invoiceDate.getDateInRequiredFormat(requiredFormat: "yyyy-MM-dd HH:mm:ss"))!).inDays.toString() + (DateTime.now().difference((invoiceDate.getDateInRequiredFormat(requiredFormat: "yyyy-MM-dd HH:mm:ss"))!).inDays >= 1 ? " days" : " day") : "0 day"} ";
}
