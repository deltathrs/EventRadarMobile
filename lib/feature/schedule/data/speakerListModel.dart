// To parse this JSON data, do
//
//     final seminarList = seminarListFromJson(jsonString);

class Speaker {
  String image;
  String nama;
  String detailname;
  String jobDetail;
  List<SeminarListElement> seminarList;

  Speaker({
    required this.image,
    required this.nama,
    required this.detailname,
    required this.jobDetail,
    required this.seminarList,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) => Speaker(
        image: json["image"],
        nama: json["nama"],
        detailname: json["detailname"],
        jobDetail: json["jobDetail"],
        seminarList: List<SeminarListElement>.from(
            json["seminarList"].map((x) => SeminarListElement.fromJson(x))),
      );
}

class SeminarListElement {
  String title;
  String desc;
  DateTime date;
  String time;
  String moda;

  SeminarListElement({
    required this.title,
    required this.desc,
    required this.date,
    required this.time,
    required this.moda,
  });

  factory SeminarListElement.fromJson(Map<String, dynamic> json) =>
      SeminarListElement(
        title: json["title"],
        desc: json["desc"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        moda: json["moda"]!,
      );
}
