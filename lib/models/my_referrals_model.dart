class MyReferralsModel {
  //declare variables
  String? id;
  String? name;
  String? date;

//create constructor
  MyReferralsModel({
    this.date,
    this.id,
    this.name,
  });

  //fromJson method
  factory MyReferralsModel.fromJson(Map<String, dynamic> json) {
    return MyReferralsModel(
      id: json['id'],
      name: json['name'],
      date: json['date'],
    );
  }

//tojson
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "date": date,
    };
  }
}
