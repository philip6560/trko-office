class Payment{

  String paymentId, note, date;
  int project, client, amount;

  Payment({this.project, this.client, this.amount, this.note,
    this.date, this.paymentId,});

  Payment.fromMap(Map<String,dynamic> map){
    paymentId = map["_id"];
    note = map["note"];
    date = map["date"];
    amount = map["amount"];
    client = map["client"];
    project = map["project"];
  }

}