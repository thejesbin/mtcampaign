class TransactionsModel {
  //declare variables
  String? id;
  String? type;
  String? comment;
  String? amount;
  String? date;
  String? time;

//create constructor
  TransactionsModel(
      {this.id, this.type, this.comment, this.amount, this.date, this.time});

  //fromJson method
  factory TransactionsModel.fromJson(Map<String, dynamic> json) {
    return TransactionsModel(
      id: json['id'],
      type: json['type'],
      comment: json['comment'],
      amount: json['amount'],
      date: json['date'],
      time: json['time'],
    );
  }

//tojson
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "comment": comment,
      "amount": amount,
      "date": date,
      "time": time,
    };
  }
}
