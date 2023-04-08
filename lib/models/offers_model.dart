class OffersModel {
  //declare variables
  String? id;
  String? name;
  String? url;
  String? amount;
  String? image;
  String? offerid;
  String? steps;

//create constructor
  OffersModel({
    this.url,
    this.id,
    this.offerid,
    this.amount,
    this.image,
    this.steps,
    this.name,
  });

  //fromJson method
  factory OffersModel.fromJson(Map<String, dynamic> json) {
    return OffersModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      url: json['url'],
      steps: json['steps'],
      offerid: json['offer_id'],
      amount: json['amount'],
    );
  }

//tojson
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "image": image,
      "url": url,
      "steps": steps,
      "offer_id": offerid,
      "amount": amount,
    };
  }
}
