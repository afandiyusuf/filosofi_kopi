class TransactionStatus{
  static const String cIN_CART = "0";
  static const String cWAITING_PAYMENT = "1";
  static const String cPAID = "2";
  static const String cSENT = "3";
  static const String cCANCEL = "4";
  static const String cCANCELLED = "5";
  static const String cDEFAULT = "6";

  static const String sIN_CART = "In Cart";
  static const String sWAITING_PAYMENT = "Menunggu Pembayaran";
  static const String sPAID = "Menunggu Pengiriman";
  static const String sCANCEL = "Dibatalkan";
  static const String sSENT = "Dikirim";
  static const String sCANCELLED = "Dibatalkan";
  static const String sDEFAULT = "Pilih Metode Pembayaran";

  static String getStringStatus(String status){
    switch(status){
      case cIN_CART:
        return sIN_CART;
        break;
      case cWAITING_PAYMENT:
        return sWAITING_PAYMENT;
        break;
      case cPAID:
        return sPAID;
        break;
      case cSENT:
        return sSENT;
        break;
      case cCANCEL:
        return sCANCEL;
        break;
      case cCANCELLED:
        return sCANCELLED;
        break;
      default:
        return sDEFAULT;
        break;
    }
  }
}