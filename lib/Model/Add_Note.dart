class Add_Note{
  int id;
  String horse_name,comment,select_date;

  Add_Note( this.horse_name,this.comment,this.select_date);

  Map<String,dynamic> toMap() => {
    "id": id,
    "horse_name":horse_name,
    "select_date":select_date,
    "comment":comment,

  };
  Add_Note.fromMap(Map<String,dynamic> data){
    horse_name=data['horse_name'];
    select_date=data['select_date'];
    comment=data['comment'];

  }
}