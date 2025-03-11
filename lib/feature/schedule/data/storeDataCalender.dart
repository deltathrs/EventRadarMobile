class Storedatacalender {
  DateTime seminarDate;
  String seminarTime;
  String seminarTitle;
  String seminarDesc;
  String seminarModa;
  Storedatacalender(
      {required this.seminarDate,
      required this.seminarTime,
      required this.seminarTitle,
      required this.seminarDesc,
      required this.seminarModa});

  factory Storedatacalender.fromJson(Map<String, dynamic> json) =>
      Storedatacalender(
          seminarDate: json["seminarDate"],
          seminarTime: json["seminarTime"],
          seminarTitle: json["seminarTitle"],
          seminarDesc: json["seminarDesc"],
          seminarModa: json["seminarModa"]);

  Map<String, dynamic> toJson() => {
        "seminarDate": seminarDate,
        "seminarTime": seminarTime,
        "seminarTitle": seminarTitle,
        "seminarDesc": seminarDesc,
        "seminarModa": seminarModa
      };
}
