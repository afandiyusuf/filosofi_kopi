class Banks{
  static const String BCA = "bca";
  static const String MANDIRI = "mandiri";
  static const String BRI = "bri";
  static const String CIMB = "cimb";
  static const String BNI = "bni";
  static const String PERMATA_VA = "permata_va";
  static const String GOPAY = "gopay";
  static const String ALFAMART = "alfamart";
  static const String CREDIT_CARD = "credit_card";

  static String getString(String input){
    if(input == PERMATA_VA){
      return "Permata Virtual Account";
    }else if(input == CREDIT_CARD){
      return "Credit Card";
    }
    return input;
  }
}

String getUrlMidtrans(String bank, String code){
  return "https://filosofikopi.id/snap/initial/$bank/$code";
}