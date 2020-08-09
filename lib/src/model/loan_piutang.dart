

class LoanPiutang {
  int id;
  int lender;
  int borrower;
  String item;
  String is_new;
  String description;
  String status_loan;
  int amount;
  String created;


  LoanPiutang(this.id, this.lender,this.borrower, this.item, this.description, this.status_loan,this.is_new,
      this.amount, this.created);

  LoanPiutang.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.lender = json['lender'];
    this.borrower = json['borrower'];
    this.item = json['item'];
    this.description = json['description'];
    this.status_loan = json['status_loan'];
    this.amount = json['amount'];
    this.created = json['created'];
    this.is_new = json['is_new'];
  }

  static List<LoanPiutang> parseList (List<dynamic> jsonList){
    List<LoanPiutang> newList = [];

    jsonList.forEach((element) {
      newList.add(LoanPiutang.fromJson(element));
    });
    return newList;
  }

}
