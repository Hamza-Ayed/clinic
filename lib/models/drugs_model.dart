import 'dart:convert';

List<Drugs> drugsFromJson(String str) =>
    List<Drugs>.from(json.decode(str).map((x) => Drugs.fromJson(x)));

String drugsToJson(List<Drugs> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Drugs {
  int ?id;
  String? drugName;
  String ?barcode;

  Drugs({
    this.id,
    this.drugName,
    this.barcode,
  });
  factory Drugs.fromJson(Map<String, dynamic> json) => Drugs(
        id: json["id"],
        drugName: json["drugName"],
        barcode: json["barcode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "drugName": drugName,
        "barcode": barcode,
      };
}
