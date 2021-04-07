class Payment{

  String paymentId, note, date, message;
  int project, client, amount, statusCode, status;

  Payment({this.project, this.client, this.amount, this.note,
    this.date, this.paymentId, this.statusCode, this.message, this.status});

  Payment.fromMap(Map<String,dynamic> map){
    paymentId = map["_id"];
    note = map["note"];
    date = map["date"];
    amount = map["amount"];
    client = map["client"];
    project = map["project"];
    message = map["message"];
    status = map["status"];
    statusCode = status == null ? map["status"]: null;
  }

}