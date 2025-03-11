class Community {
  String? image;
  String name;
  String detailCommunity;
  List<SeminarList>? seminarList;

  Community({
    required this.image,
    required this.name,
    required this.detailCommunity,
    required this.seminarList,
  });

  factory Community.fromJson(Map<String, dynamic> json) => Community(
        image: json["image"],
        name: json["name"],
        detailCommunity: json["detailCommunity"],
        seminarList: List<SeminarList>.from(
            json["seminarList"].map((x) => SeminarList.fromJson(x))),
      );
}

class SeminarList {
  String title;
  String date;
  String time;
  String moda;

  SeminarList({
    required this.title,
    required this.date,
    required this.time,
    required this.moda,
  });

  factory SeminarList.fromJson(Map<String, dynamic> json) => SeminarList(
        title: json["title"],
        date: json["date"],
        time: json["time"],
        moda: json["moda"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date": date,
        "time": time,
        "moda": moda,
      };
}
