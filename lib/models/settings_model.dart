class SettingsModel {
  //declare variables
  String? id;
  String? siteUrl;
  String? perRefer;
  String? earningPercentage;
  String? minWithdrawal;
  String? maxWithdrawal;
  String? tgChannel;
  String? tgSupport;

//create constructor
  SettingsModel({
    this.id,
    this.siteUrl,
    this.perRefer,
    this.earningPercentage,
    this.minWithdrawal,
    this.maxWithdrawal,
    this.tgChannel,
    this.tgSupport,
  });

  //fromJson method
  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      id: json['id'],
      siteUrl: json['site_url'],
      perRefer: json['per_refer'],
      earningPercentage: json['earning_percent'],
      minWithdrawal: json['min_withdrawal'],
      maxWithdrawal: json['max_withdrawal'],
      tgChannel: json['tg_channel'],
      tgSupport: json['tg_support'],
    );
  }

//tojson
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "site_url": siteUrl,
      "per_refer": perRefer,
      "earning_percent": earningPercentage,
      "min_withdrawal": minWithdrawal,
      "max_withdrawal": maxWithdrawal,
      "tg_channel": tgChannel,
      "tg_support": tgSupport,
    };
  }
}
