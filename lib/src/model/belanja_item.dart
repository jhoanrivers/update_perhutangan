
class BelanjaItem {
  int id;
  String title;
  String date;
  int createdBy;
  List<int> members;
  String createdAt;



  BelanjaItem({
    this.id,
    this.title,
    this.date,
    this.createdBy,
    this.members,
    this.createdAt,
  });


  factory BelanjaItem.fromJson(Map<String, dynamic> json) => BelanjaItem(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    members: json["members"],
    createdBy: json["created_by"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date,
    "members": members,
    "created_by": createdBy,
    "created_at": createdAt,
  };



  static List<BelanjaItem> parseListItem(List<dynamic> dataJson) {
    List<BelanjaItem> listBelanja = [];
    dataJson.forEach((element) {
      listBelanja.add(BelanjaItem.fromJson(element));
    });
    return listBelanja;
  }


}