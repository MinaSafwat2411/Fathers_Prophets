class AdminPinModel {
  final String? pin;

  AdminPinModel({
    this.pin,
  });

  factory AdminPinModel.fromJson(Map<String, dynamic> json) {
    return AdminPinModel(
    pin: json["pin"],
  );
  }

  Map<String, dynamic> toJson() {
    return {
      "pin": pin,
    };
  }
}