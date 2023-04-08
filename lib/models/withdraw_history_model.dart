class WithdrawHistoryModel {
  //declare variables
  String? id;
  String? amount;
  String? date;
  String? time;
  String? status;

//create constructor
  WithdrawHistoryModel({
    this.amount,
    this.id,
    this.date,
    this.time,
    this.status,
  });

  //fromJson method
  factory WithdrawHistoryModel.fromJson(Map<String, dynamic> json) {
    return WithdrawHistoryModel(
      id: json['id'],
      amount: json['amount'],
      time: json['time'],
      date: json['date'],
      status: json['status'],
    );
  }

//tojson
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "amount": amount,
      "time": time,
      "date": date,
      "status": status,
    };
  }
}
