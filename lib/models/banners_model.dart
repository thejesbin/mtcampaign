class BannersModel {
  //declare variables
  String? id;
  String? url;
  String? image;

//create constructor
  BannersModel({
    this.url,
    this.id,
    this.image,
  });

  //fromJson method
  factory BannersModel.fromJson(Map<String, dynamic> json) {
    return BannersModel(
      id: json['id'],
      url: json['url'],
      image: json['image'],
    );
  }

//tojson
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "url": url,
      "image": image,
    };
  }
}
