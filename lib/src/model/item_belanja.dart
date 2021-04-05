

class ItemBelanja {
  ItemBelanja({
    this.id,
    this.name,
    this.price,
    this.purchaseId,
    this.createdBy,
    this.createdAt,
  });

  int id;
  String name;
  int price;
  int purchaseId;
  int createdBy;
  DateTime createdAt;

  factory ItemBelanja.fromJson(Map<String, dynamic> json) => ItemBelanja(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    purchaseId: json["purchase_id"],
    createdBy: json["created_by"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "purchase_id": purchaseId,
    "created_by": createdBy,
    "created_at": createdAt.toIso8601String(),
  };


  static List<ItemBelanja> parseListDataLoanPiutang (List<dynamic> dataJson) {
    List<ItemBelanja> listItem = [];
    if(dataJson == null) {
      return listItem;
    } else {
      dataJson.forEach((element) {
        listItem.add(ItemBelanja.fromJson(element));
      });
      return listItem;
    }
  }


}
