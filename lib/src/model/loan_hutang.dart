

class LoanHutang {
  int id;
  int lender;
  int borrower;
  String item;
  String description;
  String status_loan;
  int amount;
  String created;


  LoanHutang(this.id, this.lender,this.borrower, this.item, this.description, this.status_loan,
      this.amount, this.created);

  LoanHutang.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.lender = json['lender'];
    this.borrower = json['borrower'];
    this.item = json['item'];
    this.description = json['description'];
    this.status_loan = json['status_loan'];
    this.amount = json['amount'];
    this.created = json['created'];
  }


  static List<LoanHutang> parseList(List<dynamic> jsonList){
    List<LoanHutang> newList = [];
    jsonList.forEach((element) {
      newList.add(LoanHutang.fromJson(element));
    });
    return newList;
  }
}
