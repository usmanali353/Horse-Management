import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:horse_management/Utils.dart';
import 'package:horse_management/HMS/Dashboard/user_dashboard_json.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:progress_dialog/progress_dialog.dart';
class graphs extends StatefulWidget{
  String token;
  graphs(this.token);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return graphsState(token);
  }

}
class graphsState extends State<graphs>{
  String token;
  var dashboard_data;
  graphsState(this.token);
  List<charts.Series> seriesList;
  Map<String, double> dataMap;
  bool isVisible=false;
  List<Color> colorList = [
    Colors.red,
    Colors.yellow,
    Colors.green,
  ];
  @override
  void initState() {
    seriesList=List<charts.Series>();
    dataMap = new Map();
    Utils.check_connectivity().then((result){
      if(result){
        ProgressDialog pd=ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: true);
        pd.show();
        DashboardServices.getUserDashboardData(token).then((response){
          pd.dismiss();
          if(response!=null){
            setState(() {
              dashboard_data=json.decode(response);
              dataMap.putIfAbsent("Males", () => dashboard_data['males']!=null?double.parse(dashboard_data['males'].toString()):0);
              dataMap.putIfAbsent("Females", () => dashboard_data['females']!=null?double.parse(dashboard_data['females'].toString()):0);
              dataMap.putIfAbsent("Gieldings", () => dashboard_data['gieldings']!=null?double.parse(dashboard_data['gieldings'].toString()):0);
              isVisible=true;
            });

          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard"),),
      body: ListView(
        children: <Widget>[
          Visibility(
            visible: isVisible,
            child: Container(
              height: MediaQuery.of(context).size.width/3,
              margin: EdgeInsets.all(8),
              child: Card(
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32.0,
                  chartRadius: MediaQuery.of(context).size.width / 2.7,
                  showChartValuesInPercentage: true,
                  showChartValues: true,
                  showChartValuesOutside: false,
                  chartValueBackgroundColor: Colors.grey[200],
                  colorList: colorList,
                  showLegends: true,
                  legendPosition: LegendPosition.right,
                  decimalPlaces: 1,
                  showChartValueLabel: true,
                  initialAngle: 0,
                  chartValueStyle: defaultChartValueStyle.copyWith(
                    color: Colors.blueGrey[900].withOpacity(0.9),
                  ),
                  chartType: ChartType.disc,
                ),
              ),
            ),
          ),
        ],

      )
    );
  }

}