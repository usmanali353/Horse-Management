class Health_Record{
  int id,amount,quantity;
  String horse_name,record_type,responsible,product,comment,currency,category,cost_center,contact;

  Health_Record(this.amount, this.quantity, this.horse_name, this.record_type,
      this.responsible, this.product, this.comment, this.currency,
      this.category, this.cost_center, this.contact);

  Map<String,dynamic> toMap() => {
    "horse_name":horse_name,
    "record_type":record_type,
    "responsible":responsible,
    "product":product,
    "comment":comment,
    "currency":currency,
    "category":category,
    "cost_center":cost_center,
    "contact":contact,
    "amount":amount,
    "quantity":quantity,
  };
  Health_Record.fromMap(Map<String,dynamic> data){
    horse_name=data['horse_name'];
    record_type=data['record_type'];
    responsible=data['responsible'];
    product=data['product'];
    comment=data['comment'];
    currency=data['currency'];
    category=data['category'];
    cost_center=data['cost_center'];
    contact=data['contact'];
    amount=data['amount'];
    quantity=data['quantity'];
  }
}