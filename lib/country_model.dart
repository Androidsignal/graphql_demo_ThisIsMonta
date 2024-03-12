class CountryModel {
  String? capital;
  String? awsRegion;
  String? code;
  List<String>? currencies;
  String? currency;
  String? emoji;
  String? emojiU;
  String? name;
  String? native;
  String? phone;

  CountryModel(
      {this.capital,
        this.awsRegion,
        this.code,
        this.currencies,
        this.currency,
        this.emoji,
        this.emojiU,
        this.name,
        this.native,
        this.phone});

  CountryModel.fromJson(Map<String, dynamic> json) {
    capital = json['capital'];
    awsRegion = json['awsRegion'];
    code = json['code'];
    currencies = json['currencies'].cast<String>();
    currency = json['currency'];
    emoji = json['emoji'];
    emojiU = json['emojiU'];
    name = json['name'];
    native = json['native'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['capital'] = capital;
    data['awsRegion'] = awsRegion;
    data['code'] = code;
    data['currencies'] = currencies;
    data['currency'] = currency;
    data['emoji'] = emoji;
    data['emojiU'] = emojiU;
    data['name'] = name;
    data['native'] = native;
    data['phone'] = phone;
    return data;
  }
}
