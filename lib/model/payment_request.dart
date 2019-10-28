class Payment {

  String caffeID;
  String tableidtimestamp;
  String tableid;
  String paymentMode;
  int paymentAmount;
  int ngoPayment;
  String paymentTimeStamp;
  String paymentResponse;

  Payment({
      this.caffeID,
      this.tableidtimestamp,
      this.tableid,
      this.paymentMode,
      this.paymentAmount,
      this.ngoPayment,
      this.paymentTimeStamp
  });

     Map<String, dynamic> toJson() => {
      "caffeID": caffeID,
      "tableidtimestamp": tableidtimestamp,
      "tableid": tableid,
      "paymentmode": paymentMode,
      "paymentamount": paymentAmount,
      "ngopayment": ngoPayment,
      "paymenttimestamp":paymentTimeStamp

     };

    Payment.fromJSON(Map<String, dynamic> json)
    : paymentResponse = json["makePayment"];  
  
}