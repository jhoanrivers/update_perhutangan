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
  String borrowerName;
  String borrowerUsername;
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
      this.borrowerName,
      this.borrowerUsername,
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
    if(dataJson['lender_name'] != null){
      this.lenderName = dataJson['lender_name'];
    } else if(dataJson['borrower_name'] != null){
      this.borrowerName = dataJson['borrower_name'];
    }
    if(dataJson['lender_username'] != null){
      this.lenderUsername = dataJson['lender_username'];
    } else if(dataJson['borrower_username'] != null){
      this.borrowerUsername = dataJson['borrower_username'];
    }

  }

  static List<LastTransaction> parseList(List<dynamic> jsonList) {
    List<LastTransaction> list = [];
    jsonList.forEach((element) {
      list.add(LastTransaction.fromJson(element));
    });
    return list;
  }
}
