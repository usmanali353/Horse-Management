import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../../Utils.dart';
class TrainingListCareTaker extends StatefulWidget {
  String token;

  TrainingListCareTaker(this.token);

  @override
  _TrainingListCareTakerState createState() => _TrainingListCareTakerState(token);
}

class _TrainingListCareTakerState extends State<TrainingListCareTaker> {
  String token;

  _TrainingListCareTakerState(this.token);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trainings"),),
      body: RefreshIndicator(
        onRefresh: (){
          return Utils.check_connectivity().then((connected){
            if(connected){
              ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
              pd.show();

            }
          });
        },
      ),
    );
  }
}

