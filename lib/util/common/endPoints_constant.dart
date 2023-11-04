/*======================== Base Urls =========================*/
import 'package:get/get.dart';
import 'package:xuriti/companyList/viewmodel/companyListVM.dart';

const String baseDevUrl = "https://dev.xuriti.app/api";
const String baseUATUrl = "https://uat.xuriti.app/api";
const String baseBizUrl = "https://biz.xuriti.app/api";
const String baseDemoUrl = "https://demo.xuriti.app/api";

/*========================  Auth Urls =========================*/
String registerUserUrl = "/auth/register-user";
String forgotPasswordUrl = "/auth/forgot-password";
String resetPasswordUrl = "/auth/reset-password/:id/:token";

/*======================== phone-verfication otp ==============*/
String otpSendUrl = "/auth/send-otp";
String otpVerifyUrl = "/auth/verify-otp";
String verifyOTPForPinURL = "/auth/reset-pin";
String resetPinForURL = "/auth/reset-pin";

/*======================== User-login-logout Urls =========================*/
String userLoginUrl = "/auth/user-login";
String userLogoutUrl = "/auth/logout";
String googleLoginUrl = "/auth/google-login";
String forgotPinURL = "/auth/forgot-pin";

/*======================== serach gst no & add entity Urls =========================*/
// this api used in UAT env without v2
String searchGstUrl = "/entity/search-gst";

// this api used in Dev env
// String searchGstUrl = "/entity/v2/search-gst";

String addEntityurl = "/entity/add-entity";

/*======================== payments and payment summary Urls =========================*/
String invoicePaymentSummary({required String companyID}) =>
    "/invoice/paymentsummary/?buyer=$companyID";
String paymentSummaryUrl(
        {required String companyID, String? sellerPan, String? payAmount}) =>
    "/payment/summary?buyer=$companyID&seller_pan=$sellerPan${payAmount != null ? "&pay_amount=$payAmount" : ""}";
String paymentTotalPayableUrl({required String? companyId}) =>
    "/payment/total_payable/$companyId";
String vouchPaymentUrl = "/payment/vouch_payment";

//Sellers related Url's
String sellerListUrl = "/entity/seller-list";
String getSellerListUrl({required String companyId}) =>
    "/payment/get_seller?buyer=$companyId";

/*======================== KYC Urls =========================*/
String aadhaarVerifyUrl = "/kyc/document-verify/aadhaar";
String panOcrUrl = "/kyc/document-verify/pan-ocr";
String panVerifyUrl = "/kyc/document-verify/pan";
String eKycGetCaptchaUrl = "/kyc/ekyc-getcaptcha";
String eKycVerifyOTPUrl = "/kyc/ekyc-verifyOtp";
String captchaVerifyUrl = "/kyc/ekyc-verifyCaptcha"; //generate adhar otp
String entityOnboardUrl = "/entity/onboard"; //save kyc documents
String phoneRequestOTPUrl = "/kyc/phone-verification/request-otp";
String phoneVerifyOTPUrl = "/kyc/phone-verification/verify-otp";
String kycStatusUrl({required String companyid}) => '/kyc/$companyid/document';

/*======================== profile manager related Url's =========================*/
String update_deleteProfileurl({required String? userID}) => "/user/$userID";
String getTermsConditionsUrl = "/user/termsconditions";

String getContactUsUrl = "https://www.xuriti.com/contact-us/";
String launchXUrl = "https://www.xuriti.com/";

/*======================== Rewards Related Url's =========================*/
String getRewardUrl = "/user/rewards";

/*======================== Transaction Payment History & History Details Url's =========================*/
String transactionPaymentHistoryUrl(
    {required String? buyerId,
    String? sellerId,
    int? upperLimit,
    int? lowerLimit}) {
  String? baseurl;

//TODO : Check for pagination status
//   if (false) {
//     sellerId == null
//         ? baseurl =
//             "/payment/transctionshistory?buyer=$buyerId&lowerLimit=$lowerLimit&upperLimit=$upperLimit"
//         : baseurl =
//             "/payment/transctionshistory?buyer=$buyerId&seller=$sellerId&lowerLimit=$lowerLimit&upperLimit=$upperLimit";
//   } else {
  baseurl =
      //  "/payment/transctionshistory?buyer=$buyerId${sellerId == null ? "" : "&seller=$sellerId"}";
      "/payment/v2/transctionshistory?buyer=$buyerId${sellerId == null ? "" : "&seller=$sellerId"}";
//  }

  return baseurl;
}

//Transaction Manager Ledger and Statement related Url's
String transactionLedger({required String? companyId}) =>
    "/ledger/companies/transaction_ledger?buyer=$companyId";
String transactionalStatementUrl({required String? companyId}) =>
    "ledger/companies/transaction_ledger/$companyId";
String transactionStatment({required String? companyId}) =>
    '/ledger/statement/buyer/$companyId';
String transactionalLedgerDownloadUrl({required String companyId}) =>
    '/ledger/$companyId/statement/download';
String transactionalStatementDownloadUrl({required String companyId}) =>
    '/ledger/$companyId/transaction-statement/download';

/*======================= Invoice Related Url's ===================== */
// String getInvoiceDetailsUrl({required String invoiceId}) =>
//     "/invoice/invoices?_id=$invoiceId";

/****************************** need to be check *************************************** */
String InvoicesListAndDetailsEndpoint(
    {String? invoiceId,
    String? sellerPan,
    String? invoiceType,
    String? invoiceStatus,
    String? multiInvStatusA,
    String? multiInvStatusB,
    String? limit,
    String? page}) {
  CompanyListViewModel companyListViewModel = Get.put(CompanyListViewModel());

  String baseInvoiceURL =
      "/invoice/search-invoice/${companyListViewModel.selectedCompany.value?.companyId ?? ""}/buyer";

  List<String> queryParams = [];
  if (invoiceId != null) {
    queryParams.add("invoice_id=$invoiceId");
  }
  if (sellerPan != null) {
    queryParams.add("pan_number=$sellerPan");
    // queryParams.add("seller=$sellerID");
  }
  if (invoiceType != null) {
    queryParams.add("invoice_type=$invoiceType");
  }
  if (invoiceStatus != null) {
    queryParams.add("invoice_status=$invoiceStatus");
  }
  if (multiInvStatusA != null) {
    queryParams.add("multi_invoice_status_A=$multiInvStatusA");
  }
  if (multiInvStatusB != null) {
    queryParams.add("multi_invoice_status_B=$multiInvStatusB");
  }
  if (invoiceType?.toLowerCase() == "cn") {
    queryParams.add("filterFor=mobile");
  }
  // if (page != null && limit != null) {
  //   queryParams.add("page=$page&limit=$limit");
  // }
  ///TODO : Add pagination Logic for invoices
  if (queryParams.isNotEmpty) {
    baseInvoiceURL += "?" + queryParams.join("&");
  }

  return baseInvoiceURL;
}

// String searchInvoiceUrl(
//         {required String? buyerId,
//         String? confirm_filter,
//         String? invoceId,
//         String? invoiceStatus,
//         String? sellerId,
//         int? pagination_limit,
//         int? pagination_page,
//         String? invoiceType}) =>
//     "/invoice/search-invoice/$buyerId/buyer?invoice_id=$invoceId?${confirm_filter != null ? "&seller=$confirm_filter" : ""} &invoice_type=$invoiceType&invoice_status=$invoiceStatus&multi_invoice_status_A=Confirmed&multi_invoice_status_B=Partpay&&limit=5&page=1";
// String cnInvoiceFilterUrl(
//         {required String id,
//         String? cn_filter,
//         String? invoiceType,
//         int? pagination_limit,
//         int? pagination_page}) =>
//     "/invoice/search-invoice/$id/buyer?${cn_filter != null ? "&seller=$cn_filter" : ""}&invoice_type=$invoiceType&limit=$pagination_limit&page=$pagination_page";
String invoiceStatus = "/invoice/status";

/*========================== Credit Limit Url's ================================*/

String getCompanyDetailsUrl({required String? companyId}) =>
    "/entity/entity/$companyId"; //getcomapnydetails
String getComapnyListUrl({required String? id}) => "/entity/entities/$id";

String getCreditandAvailableLimit({required String? companyId}) =>
    "/entity/credit_details/$companyId"; // Get credit details data

/*========================== Interactive Dialogue Url's ================================*/

String getInteractiveGreetMessageUrl(
    {String? id, required String dialogType, String? lastGreetTimeStamp}) {
  String baseInteractiveMessageURL =
      "/invoice/splash-screen/$dialogType?lastGreetTimestamp=$lastGreetTimeStamp${id == null ? "" : "&id=$id"}";

  return baseInteractiveMessageURL;
}
