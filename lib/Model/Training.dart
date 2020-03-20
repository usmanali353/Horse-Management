
class Training {
  String horse_name,trainer_name,training_type,training_center,start_date,end_date,target_date,excercise_plan,target_competition;
  int id,horse_id,trainer_id,training_type_id,excercise_plan_id;

  Training(this.horse_name, this.trainer_name, this.training_type,
      this.training_center, this.start_date, this.end_date, this.target_date,
      this.excercise_plan, this.horse_id, this.trainer_id,
      this.training_type_id, this.excercise_plan_id,this.target_competition);

  Map<String,dynamic> toMap()=>{
     "id" : id,
      "horse_name": horse_name,
      "horse_id": horse_id,
      "trainer_name":trainer_name,
      "trainer_id":trainer_id,
      "training_type": training_type,
      "training_type_id":training_type_id,
      "training_center":training_center,
      "start_date":start_date,
      "end_date":end_date,
      "target_date":target_date,
      "excercise_plan":excercise_plan,
      "excercise_plan_id":excercise_plan_id,
      "target_competition":target_competition,
  };
  Training.fromMap(Map<dynamic,dynamic> data){
    id=data['id'];
    trainer_name=data['trainer_name'];
    trainer_id=data['trainer_id'];
    horse_name=data['horse_name'];
    horse_id=data['horse_id'];
    training_center=data['training_center'];
    training_type=data['training_type'];
    training_type_id=data['training_type_id'];
    start_date=data['start_date'];
    end_date=data['end_date'];
    target_date=data['target_date'];
    excercise_plan=data['excercise_plan'];
    excercise_plan_id=data['excercise_plan_id'];
    target_competition=data['target_competition'];
  }
}


