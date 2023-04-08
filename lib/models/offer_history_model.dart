class OfferHistoryModel {
  //declare variables
  String? id;
  String? campName;
  String? date;
  String? amount;
  String? time;

//create constructor
  OfferHistoryModel({
    this.date,
    this.id,
    this.time,
    this.amount,
    this.campName,
  });

  //fromJson method
  factory OfferHistoryModel.fromJson(Map<String, dynamic> json) {
    return OfferHistoryModel(
      id: json['id'],
      campName: json['camp_name'],
      date: json['date'],
      time: json['time'],
      amount: json['amount'],
    );
  }

//tojson
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "camp_name": campName,
      "date": date,
      "time": time,
      "amount": amount,
    };
  }
}
