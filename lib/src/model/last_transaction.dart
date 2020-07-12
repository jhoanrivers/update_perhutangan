class LastTransaction {
  int id;
  int lender;
  int borrower;
  String item;
  String description;
  String statusLoan;
  int amount;
  String created;
  String ovoName;
  String ovo;
  String gopayName;
  String gopay;
  String lenderName;
  String lenderUsername;

  LastTransaction(
      this.id,
      this.lender,
      this.borrower,
      this.item,
      this.description,
      this.statusLoan,
      this.amount,
      this.created,
      this.ovoName,
      this.ovo,
      this.gopayName,
      this.gopay,
      this.lenderName,
      this.lenderUsername);

  LastTransaction.fromJson(Map<String, dynamic> dataJson) {
    this.id = dataJson['id'];
    this.lender = dataJson['lender'];
    this.borrower = dataJson['borrower'];
    this.item = dataJson['item'];
    this.description = dataJson['description'];
    this.statusLoan = dataJson['status_loan'];
    this.amount = dataJson['amount'];
    this.created = dataJson['created'];
    this.ovoName = dataJson['ovo_name'];
    this.ovo = dataJson['ovo'];
    this.gopay = dataJson['gopay'];
    this.gopayName = dataJson['gopay_name'];
    this.lenderName = dataJson['lender_name'];
    this.lenderUsername = dataJson['lender_username'];
  }

  static List<LastTransaction> parseList(List<dynamic> jsonList) {
    List<LastTransaction> list = [];
    jsonList.forEach((element) {
      list.add(LastTransaction.fromJson(element));
    });
    return list;
  }
}
