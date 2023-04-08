class UserAccountModel {
  String? totalEarnings;
  String? totalReferEarnings;
  String? totalWithdrawal;
  int? totalReferrals;
  List<User>? user;

  UserAccountModel({
    this.totalEarnings,
    this.totalReferEarnings,
    this.totalWithdrawal,
    this.totalReferrals,
    this.user,
  });
  factory UserAccountModel.fromJson(Map<String, dynamic> json) {
    return UserAccountModel(
      totalEarnings: json['total_earnings'],
      totalReferEarnings: json['total_refer_earnings'],
      totalWithdrawal: json['total_withdrawal'],
      totalReferrals: json['total_referrals'],
      user: json['result'] != null
          ? List<User>.from(json["result"].map((x) => User.fromJson(x)))
          : null,
    );
  }
}

class User {
  String? id;
  String? name;

  String? email;
  String? phone;
  String? balance;
  String? referCode;

  User({
    this.email,
    this.id,
    this.phone,
    this.balance,
    this.referCode,
    this.name,
  });
  //fromJson method
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      phone: json['phone'],
      balance: json['balance'],
      referCode: json['refer_code'],
      name: json['name'],
    );
  }
}
