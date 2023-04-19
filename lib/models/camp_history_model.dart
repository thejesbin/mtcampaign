class CampHistoryModel {
  //declare variables
  String? id;
  String? uid;
  String? title;
  String? image;
  String? amount;
  String? status;
  String? oid;

//create constructor
  CampHistoryModel({
    this.title,
    this.id,
    this.amount,
    this.image,
    this.uid,
    this.status,
    this.oid,
  });

  //fromJson method
  factory CampHistoryModel.fromJson(Map<String, dynamic> json) {
    return CampHistoryModel(
      id: json['id'],
      uid: json['uid'],
      title: json['title'],
      amount: json['amount'],
      image: json['image'],
      status: json['status'],
      oid: json['oid'],
    );
  }

//tojson
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uid": uid,
      "title": title,
      "amount": amount,
      "image": image,
      "status": status,
      "oid": oid,
    };
  }
}
