class WeatherModel {
  int? date;
  double? temp;
  int? humidity;
  String? description;
  String? iconImage;
  String? locName;

  WeatherModel({
    required this.date,
    required this.temp,
    required this.humidity,
    required this.description,
    required this.iconImage,
    required this.locName,
  });

  // json data to model
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      date: json['list'][0]['dt'],
      temp: json['list'][0]['main']['temp'],
      humidity: json['list'][0]['main']['humidity'],
      description: json['list'][0]['weather'][0]['main'],
      iconImage: json['list'][0]['weather'][0]['icon'],
      locName: json['city']['name'],
    );
  }
  factory WeatherModel.fromJson2(Map<String, dynamic> json) {
    return WeatherModel(
      date: json['list'][3]['dt'],
      temp: json['list'][3]['main']['temp'],
      humidity: json['list'][3]['main']['humidity'],
      description: json['list'][3]['weather'][0]['main'],
      iconImage: json['list'][3]['weather'][0]['icon'],
      locName: json['city']['name'],
    );
  }
  factory WeatherModel.fromJson3(Map<String, dynamic> json) {
    return WeatherModel(
      date: json['list'][10]['dt'],
      temp: json['list'][10]['main']['temp'],
      humidity: json['list'][10]['main']['humidity'],
      description: json['list'][10]['weather'][0]['main'],
      iconImage: json['list'][10]['weather'][0]['icon'],
      locName: json['city']['name'],
    );
  }

  // model to json
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'temp': temp,
      'humidity': humidity,
      'description': description,
      'iconImage': iconImage,
      'locName': locName,
    };
  }
}
